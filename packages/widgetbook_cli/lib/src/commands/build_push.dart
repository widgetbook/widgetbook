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
import 'review_sync.dart';
import 'review_sync_args.dart';

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
          name: 'build push',
          description: 'Pushes a new build to Widgetbook Cloud',
        ) {
    argParser
      ..addOption(
        'api-key',
        help: 'The project specific API key for Widgetbook Cloud.',
        mandatory: true,
      )
      ..addOption(
        'path',
        help: 'The path to the build folder of your application.',
        defaultsTo: './',
      )
      ..addOption(
        'branch',
        help: 'The name of the branch for which the Widgetbook is uploaded.',
      )
      ..addOption(
        'commit',
        help:
            'The SHA hash of the commit for which the Widgetbook is uploaded.',
      )
      ..addOption(
        'actor',
        help: 'The username of the actor which triggered the build.',
      )
      ..addOption(
        'sync-reviews-of',
        help: 'The base branch of the pull-request. For example, main.',
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

    final baseBranchName = results['sync-reviews-of'] as String?;
    final baseBranch = baseBranchName == null
        ? null
        : await repository.findBranch(
            baseBranchName,
            remote: true,
          );

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
      baseBranch: baseBranch,
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
        headSha: args.commit,
        baseSha: args.baseBranch?.sha,
        useCases: useCases,
      ),
    );

    final buildId = buildDraft.buildId;
    final signedUrl = buildDraft.storageUrl;
    draftProgress.complete('Build draft [$buildId] created');

    final archiveProgress = logger.progress('Creating build archive');
    final buildDirPath = p.join(args.path, 'build', 'web');
    final buildDir = fileSystem.directory(buildDirPath);
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

    submitProgress.complete('Build ready at ${response.buildUrl}');

    /// TODO: remove this once the `review sync` command works without a build
    if (args.baseBranch != null) {
      final syncCmd = ReviewSyncCommand(
        context: context,
        fileSystem: fileSystem,
        processManager: processManager,
      );

      await syncCmd.runWith(
        context,
        ReviewSyncArgs(
          apiKey: args.apiKey,
          path: args.path,
          buildId: buildId,
          baseBranch: args.baseBranch!.name,
          headBranch: args.branch,
          baseSha: args.baseBranch!.sha,
          headSha: args.commit,
        ),
      );
    }

    return 0;
  }
}
