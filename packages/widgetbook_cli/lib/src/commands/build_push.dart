import 'dart:async';

import 'package:args/src/arg_results.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path/path.dart' as p;
import 'package:process/process.dart';

import '../../widgetbook_cli.dart';
import '../api/models/build_draft_request.dart';
import '../api/models/build_ready_request.dart';
import '../utils/executable_manager.dart';
import 'build_push_args.dart';

class BuildPushCommand extends CliCommand<BuildPushArgs> {
  BuildPushCommand({
    required super.context,
    this.processManager = const LocalProcessManager(),
    this.fileSystem = const LocalFileSystem(),
    this.zipEncoder = const ZipEncoder(),
    this.useCaseReader = const UseCaseReader(),
  })  : client = WidgetbookHttpClient(
          environment: context.environment,
        ),
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
        'actor',
        help: 'Author of the commit',
      );
  }

  final WidgetbookHttpClient client;
  final ProcessManager processManager;
  final FileSystem fileSystem;
  final ZipEncoder zipEncoder;
  final UseCaseReader useCaseReader;

  @override
  FutureOr<BuildPushArgs> parseResults(
    Context context,
    ArgResults results,
  ) async {
    final path = results['path'] as String;
    final apiKey = results['api-key'] as String;

    final repository = context.repository!;
    final currentBranch = await repository.currentBranch;
    final branch = results['branch'] as String? ?? currentBranch.name;
    final commit = results['commit'] as String? ??
        context.providerSha ??
        currentBranch.sha;

    final actor = results['actor'] as String? ?? context.user;
    if (actor == null) {
      throw ActorNotFoundException();
    }

    final repoName = results['repository'] as String? ?? context.project;
    if (repoName == null) {
      throw RepositoryNotFoundException();
    }

    return BuildPushArgs(
      apiKey: apiKey,
      branch: branch,
      commit: commit,
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

    final useCasesProgress = logger.progress('Reading use-cases');
    final useCases = await useCaseReader.read(args.path);

    if (useCases.isEmpty) {
      useCasesProgress.fail(
        'No use-cases found\n\n'
        'Make sure you have done the following:\n'
        ' 1. Ran `dart run build_runner build -d` to generate metadata files.\n'
        ' 2. Included at least one use-case in your project.'
        ' 3. Ran the CLI from within the directory that contains your `.dart_tool`',
      );

      return 21;
    }

    useCasesProgress.complete('${useCases.length} Use-case(s) read');

    final draftProgress = logger.progress('Creating build draft');
    final buildDraft = await client.createBuildDraft(
      versions,
      BuildDraftRequest(
        apiKey: args.apiKey,
        versionControlProvider: args.vendor,
        repository: args.repository,
        actor: args.actor,
        branch: args.branch,
        sha: args.commit,
        useCases: useCases,
      ),
    );

    final buildId = buildDraft.buildId;
    final signedUrl = buildDraft.storageUrl;
    draftProgress.complete('Build draft [$buildId] created');

    final archiveProgress = logger.progress('Creating build archive');
    final buildDirPath = p.join(args.path, 'build', 'web');
    final buildDir = fileSystem.directory(buildDirPath);

    if (!buildDir.existsSync()) {
      archiveProgress.fail();
      logger.err(
        'build/web directory does not exist.\n'
        'Run the following command before publishing:\n\n\t'
        'flutter build web --target path/to/widgetbook.dart\n\n',
      );
      return 22;
    }

    final zipFile = await zipEncoder.zip(buildDir, '$buildId.zip');
    if (zipFile == null) {
      archiveProgress.fail('Failed to create build archive');
      return 23;
    }

    archiveProgress.complete('Build archive created at ${zipFile.path}');

    final uploadProgress = logger.progress('Uploading build archive');
    await client.uploadBuildFile(signedUrl, zipFile);
    uploadProgress.complete('Build archive uploaded');

    final submitProgress = logger.progress('Submitting build');
    final response = await client.submitBuildDraft(
      BuildReadyRequest(
        apiKey: args.apiKey,
        buildId: buildId,
      ),
    );

    submitProgress.complete('Build will be ready at ${response.buildUrl}');

    return 0;
  }
}
