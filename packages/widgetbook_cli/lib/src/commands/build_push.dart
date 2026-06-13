import 'dart:async';
import 'dart:convert';

import 'package:args/args.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';
import 'package:process/process.dart';

import '../api/api.dart';
import '../cache/cache.dart';
import '../core/core.dart';
import '../storage/storage.dart';
import '../utils/build_hasher.dart';
import '../utils/executable_manager.dart';
import 'build_push_args.dart';

class BuildPushCommand extends CliCommand<BuildPushArgs> {
  BuildPushCommand({
    required super.context,
    super.logger,
    this.processManager = const LocalProcessManager(),
    this.fileSystem = const LocalFileSystem(),
    this.cacheReader = const CacheReader(),
    this.buildHasher = const BuildHasher(),
    WidgetbookHttpClient? cloudClient,
    StorageClient? storageClient,
  }) : cloudClient = cloudClient ?? WidgetbookHttpClient(),
       storageClient = storageClient ?? StorageClient(),
       super(
         name: 'push',
         description: 'Pushes a new build to Widgetbook Cloud',
       ) {
    argParser
      ..addOption(
        'api-key',
        help: "Project's API key from setting page on Widgetbook Cloud",
        mandatory: true,
      )
      ..addOption(
        'path',
        help: "Path to the `build` folder's parent (i.e. the project root)",
        defaultsTo: './',
      )
      ..addOption(
        'repository',
        help: 'Repository name (e.g. widgetbook/cool-app) ',
      )
      ..addOption(
        'branch',
        help: 'Branch name (e.g. main, feature/cool-feature)',
      )
      ..addOption(
        'commit',
        help: 'Full commit SHA',
      )
      ..addOption(
        'merged-result-commit',
        help:
            'For GitLab Merged Results, '
            'this commit will be used for commit status.',
      )
      ..addOption(
        'actor',
        help: 'Author of the commit',
      )
      ..addOption(
        'api-url',
        hide: true,
        callback: (url) {
          if (url == null) return;
          this.cloudClient.client.options.baseUrl = url;
        },
      )
      ..addFlag(
        'no-turbo',
        hide: true,
      );
  }

  final WidgetbookHttpClient cloudClient;
  final StorageClient storageClient;
  final ProcessManager processManager;
  final FileSystem fileSystem;
  final CacheReader cacheReader;
  final BuildHasher buildHasher;

  @override
  FutureOr<BuildPushArgs> parseResults(
    Context context,
    ArgResults results,
  ) async {
    final path = results['path'] as String;
    final apiKey = results['api-key'] as String;

    final repository = context.repository;

    if (repository == null) {
      throw CliException(
        'No repository found.\n'
        'Make sure you are in a git repository '
        'or run `git init` to initialize a new one.',
        ExitCode.data.code,
      );
    }

    final currentBranch = await repository.currentBranch;

    final branch =
        results['branch'] as String? ??
        context.providerBranch ??
        currentBranch.name;

    if (branch == 'HEAD') {
      throw CliException(
        'Branch name cannot be "HEAD". '
        'To make sure that Visual PRs work correctly, '
        'please use a specific branch name.\n\n'
        'For more information, check our docs:\n'
        '1. https://docs.widgetbook.io/cloud/visual-pull-request/create#how-visual-pull-requests-connect-with-builds\n'
        '2. https://docs.widgetbook.io/cloud/builds/upload#upload-build-using-cicd',
        ExitCode.data.code,
      );
    }

    final commit =
        results['commit'] as String? ??
        context.providerSha ??
        currentBranch.sha;

    final mergedResultCommit = results['merged-result-commit'] as String?;

    final actor = results['actor'] as String? ?? context.user;
    if (actor == null) {
      throw MissingOptionException('actor');
    }

    final repoName = results['repository'] as String? ?? context.project;
    if (repoName == null) {
      throw MissingOptionException('repository');
    }

    final noTurbo = results['no-turbo'] as bool;

    return BuildPushArgs(
      apiKey: apiKey,
      branch: branch,
      commit: commit,
      mergedResultCommit: mergedResultCommit,
      path: path,
      vendor: context.name,
      actor: actor,
      repository: repoName,
      noTurbo: noTurbo,
    );
  }

  @override
  FutureOr<int> runWith(Context context, BuildPushArgs args) async {
    final lockPath = p.join(args.path, 'pubspec.lock');
    final versions = await VersionsMetadata.from(
      lockFile: fileSystem.file(lockPath),
      flutterVersionOutput: await processManager.runFlutter(['--version']),
    );

    final cacheProgress = logger.progress('Reading cache');
    final cache = await cacheReader.read(args.path);

    if (cache.isEmpty) {
      final absolutePath = p.absolute(args.path);

      cacheProgress.fail(
        'No cache files were found in ${absolutePath}\n\n'
        'Make sure you have done the following:\n'
        ' 1. Included at least one story in your project.\n'
        ' 2. Ran `flutter test` to generate snapshot files.\n'
        ' 3. Ran the CLI from the directory that contains your `build` folder',
      );

      return 21;
    }

    cacheProgress.complete(
      'Cache: ${cache.scenarios.length} Snapshot(s)',
    );

    final filesProgress = logger.progress('Reading Files');

    final buildDirPath = p.join(args.path, 'build', 'web');
    final buildDir = fileSystem.directory(buildDirPath);

    if (!buildDir.existsSync()) {
      logger.err(
        'build/web directory does not exist.\n'
        'Run the following command before publishing:\n\n\t'
        'flutter build web --target path/to/widgetbook.dart\n\n',
      );
      return 22;
    }

    // If `-no-turbo` is passed, we skip the hashing step
    // as it is not needed for non-turbo builds.
    final hash = args.noTurbo
        ? null
        : await buildHasher.convert(
            buildDir,
          );

    final files =
        buildDir //
            .listSync(recursive: true)
            .whereType<File>();

    final dirSize = files.fold<int>(
      0,
      (previousValue, file) => previousValue + file.statSync().size,
    );

    filesProgress.complete('${files.length} File(s) read');

    // Derive the unique stories from the scenarios. A "story" is a logical UI
    // permutation; multiple scenarios (e.g. different modes/args) can share one
    // story. We dedup by the owning story's navPath, which is
    // `component.path + "/" + component.name + "/" + story.name` — the exact
    // formula the server uses to compute the deterministic story id that links
    // appended snapshots back to their story.
    final storiesByNavPath = <String, StoryRecord>{};
    for (final scenario in cache.scenarios) {
      storiesByNavPath.putIfAbsent(
        scenario.storyNavPath,
        () => StoryRecord(
          component: scenario.component,
          story: scenario.story,
          navPath: scenario.storyNavPath,
        ),
      );
    }
    final stories = storiesByNavPath.values.toList();

    final createProgress = logger.progress('Creating build');
    final createResponse = await cloudClient.createBuild(
      versions,
      CreateBuildRequest(
        apiKey: args.apiKey,
        versionControlProvider: args.vendor,
        repository: args.repository,
        actor: args.actor,
        branch: args.branch,
        sha: args.commit,
        mergedResultSha: args.mergedResultCommit,
        stories: stories,
        expectedSnapshotCount: cache.scenarios.length,
        size: dirSize + cache.totalSnapshotSize,
        hash: hash,
      ),
    );

    if (createResponse.isTurbo) {
      final turboResponse = createResponse.asTurbo;

      createProgress.complete(
        '🚀 Turbo build is ready at ${turboResponse.buildUrl}',
      );

      return 0;
    }

    createProgress.complete('Draft build [${createResponse.buildId}] created');

    final draftResponse = createResponse.asDraft;

    // Stream the snapshot metadata to the build in byte-bounded batches. The
    // image bytes themselves are uploaded separately, direct to S3 (below);
    // here we only send the lightweight per-snapshot records so the create
    // request stays tiny. Each snapshot's navPath is its OWNING STORY's
    // navPath (the same string used in the StoryRecord above), NOT the
    // scenario path — the server links the snapshot to its story by that.
    await _appendSnapshots(
      versions: versions,
      apiKey: args.apiKey,
      buildId: createResponse.buildId,
      scenarios: cache.scenarios,
    );

    final buildUploadProgress = logger.progress('Uploading build files');

    // Prepare web build files
    final buildFiles = files.map(
      (file) {
        final key = p.relative(
          file.path,
          from: buildDirPath,
        );

        if (key != 'index.html') {
          return StorageObject(
            key: key,
            size: file.statSync().size,
            reader: file.openRead,
          );
        }

        // Modify index.html to include the correct base href
        final content = file.readAsStringSync();
        final modifiedContent = content.replaceFirst(
          RegExp('<base href=".*" ?\/?>'),
          '<base href="${draftResponse.baseHref}">',
        );

        return StorageObject(
          key: key,
          size: modifiedContent.length,
          reader: () => Stream.value(
            modifiedContent.codeUnits,
          ),
        );
      },
    );

    await storageClient.uploadObjects(
      draftResponse.storage.url,
      draftResponse.storage.fields,
      buildFiles,
    );

    buildUploadProgress.complete('Build files uploaded');

    final snapshotUploadProgress = logger.progress('Uploading snapshots');

    // Prepare snapshot image files and metadata files
    final snapshotFiles = cache.scenarios.map((scenario) {
      final imagePath = p.join(args.path, scenario.image.path);
      final imageFile = fileSystem.file(imagePath);
      final hash = scenario.image.hash;

      // Use key sharding to distribute snapshots across multiple S3 prefixes
      // This prevents hitting AWS S3 request rate limits on a single prefix
      // Format: {first2chars}/{hash}.png (e.g., "a1/a1b2c3d4.png")
      final shard = hash.substring(0, 2);
      return StorageObject(
        key: '$shard/$hash.png',
        size: scenario.image.size,
        reader: imageFile.openRead,
      );
    });

    await storageClient.uploadObjects(
      draftResponse.snapshotStorage.url,
      draftResponse.snapshotStorage.fields,
      snapshotFiles,
    );

    snapshotUploadProgress.complete('Snapshots uploaded');

    final submitProgress = logger.progress('Submitting build');
    final submitResponse = await cloudClient.submitBuild(
      SubmitBuildRequest(
        apiKey: args.apiKey,
        buildId: createResponse.buildId,
      ),
    );

    submitProgress.complete(
      'Build will be ready at ${submitResponse.buildUrl}',
    );

    return 0;
  }

  /// Builds a [SnapshotRecord] per cache scenario, packs them into
  /// byte-bounded batches, and POSTs each batch to
  /// `v4/builds/{buildId}/snapshots` with bounded parallelism.
  Future<void> _appendSnapshots({
    required VersionsMetadata? versions,
    required String apiKey,
    required String buildId,
    required List<ScenarioRecord> scenarios,
  }) async {
    final appendProgress = logger.progress('Appending snapshots');

    final records = scenarios.map((scenario) {
      return SnapshotRecord(
        scenario: scenario.scenario,
        image: scenario.image,
        // The OWNING STORY's navPath, NOT the scenario path. The server links
        // the snapshot to its story via deterministicStoryId(buildId, navPath).
        navPath: scenario.storyNavPath,
        semantics: scenario.semantics,
      );
    }).toList();

    final batches = _batchSnapshots(records);

    // Bounded parallelism, mirroring how the snapshot image uploads are
    // parallelized (see `StorageClient.uploadObjects`).
    final pool = Pool(
      _maxConcurrentAppendRequests,
      timeout: const Duration(seconds: 30),
    );

    var completed = 0;
    final promises = batches.map((batch) async {
      await pool.withResource(
        () => cloudClient.appendSnapshots(
          versions,
          buildId,
          AppendSnapshotsRequest(
            apiKey: apiKey,
            snapshots: batch,
          ),
        ),
      );

      completed += batch.length;
      appendProgress.update(
        'Appending snapshots ($completed/${records.length})',
      );
    });

    await Future.wait(promises, eagerError: true);

    appendProgress.complete(
      '${records.length} Snapshot(s) appended in ${batches.length} batch(es)',
    );
  }

  /// Packs [records] into batches whose JSON-encoded size stays under
  /// [_maxBatchSizeBytes], capping each batch at [_maxSnapshotsPerBatch]
  /// records as a safety bound. A single record larger than the budget still
  /// gets its own batch (we never drop a record).
  List<List<SnapshotRecord>> _batchSnapshots(List<SnapshotRecord> records) {
    final batches = <List<SnapshotRecord>>[];
    var current = <SnapshotRecord>[];
    var currentBytes = 0;

    for (final record in records) {
      final recordBytes = utf8.encode(jsonEncode(record.toJson())).length;

      final wouldExceedBytes =
          current.isNotEmpty && currentBytes + recordBytes > _maxBatchSizeBytes;
      final wouldExceedCount = current.length >= _maxSnapshotsPerBatch;

      if (wouldExceedBytes || wouldExceedCount) {
        batches.add(current);
        current = <SnapshotRecord>[];
        currentBytes = 0;
      }

      current.add(record);
      currentBytes += recordBytes;
    }

    if (current.isNotEmpty) {
      batches.add(current);
    }

    return batches;
  }
}

/// Target byte budget for a single append batch (~1 MB of JSON-encoded
/// snapshot records). Keeps each append request small so the server task
/// never has to parse one giant body.
const _maxBatchSizeBytes = 1024 * 1024;

/// Safety cap on the number of snapshot records per append batch, independent
/// of the byte budget.
const _maxSnapshotsPerBatch = 1000;

/// Bounded parallelism for append requests, mirroring the snapshot image
/// upload pool in `StorageClient`.
const _maxConcurrentAppendRequests = 8;
