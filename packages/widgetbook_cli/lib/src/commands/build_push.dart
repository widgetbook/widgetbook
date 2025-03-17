import 'dart:async';

import 'package:args/args.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:process/process.dart';

import '../api/api.dart';
import '../cache/cache.dart';
import '../core/core.dart';
import '../storage/storage.dart';
import '../utils/executable_manager.dart';
import 'build_push_args.dart';

class BuildPushCommand extends CliCommand<BuildPushArgs> {
  BuildPushCommand({
    required super.context,
    this.processManager = const LocalProcessManager(),
    this.fileSystem = const LocalFileSystem(),
    this.cacheReader = const CacheReader(),
    WidgetbookHttpClient? cloudClient,
    StorageClient? storageClient,
  })  : cloudClient = cloudClient ?? WidgetbookHttpClient(),
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
        help: 'For GitLab Merged Results, '
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
      );
  }

  final WidgetbookHttpClient cloudClient;
  final StorageClient storageClient;
  final ProcessManager processManager;
  final FileSystem fileSystem;
  final CacheReader cacheReader;

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

    final branch = results['branch'] as String? ??
        context.providerBranch ??
        currentBranch.name;

    final commit = results['commit'] as String? ??
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

    return BuildPushArgs(
      apiKey: apiKey,
      branch: branch,
      commit: commit,
      mergedResultCommit: mergedResultCommit,
      path: path,
      vendor: context.name,
      actor: actor,
      repository: repoName,
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
        ' 1. Ran `dart run build_runner build -d` to generate cache files.\n'
        ' 2. Included at least one use-case in your project.\n'
        ' 3. Ran the CLI from the directory that contains your `.dart_tool`',
      );

      return 21;
    }

    cacheProgress.complete(
      'Cache: ${cache.useCases.length} Use-case(s) '
      '+ ${cache.addonsConfigs?.length ?? 0} AddonsConfig(s)',
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

    final files = buildDir //
        .listSync(recursive: true)
        .whereType<File>();

    final dirSize = files.fold<int>(
      0,
      (previousValue, file) => previousValue + file.statSync().size,
    );

    filesProgress.complete('${files.length} File(s) read');

    final draftProgress = logger.progress('Creating build draft');
    final buildDraft = await cloudClient.createBuildDraft(
      versions,
      BuildDraftRequest(
        apiKey: args.apiKey,
        versionControlProvider: args.vendor,
        repository: args.repository,
        actor: args.actor,
        branch: args.branch,
        sha: args.commit,
        mergedResultSha: args.mergedResultCommit,
        useCases: cache.useCases,
        addonsConfigs: cache.addonsConfigs,
        size: dirSize,
      ),
    );

    draftProgress.complete('Build draft [${buildDraft.buildId}] created');

    final uploadProgress = logger.progress('Uploading build files');

    final objects = files.map(
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
          '<base href="${buildDraft.baseHref}">',
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
      buildDraft.storage.url,
      buildDraft.storage.fields,
      objects,
    );

    uploadProgress.complete('Build files uploaded');

    final submitProgress = logger.progress('Submitting build');
    final response = await cloudClient.submitBuildDraft(
      BuildReadyRequest(
        apiKey: args.apiKey,
        buildId: buildDraft.buildId,
      ),
    );

    submitProgress.complete('Build will be ready at ${response.buildUrl}');

    return 0;
  }
}
