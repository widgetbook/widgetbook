import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:process/process.dart';

import '../api/api.dart';
import '../core/core.dart';
import '../git/git.dart';
import '../utils/executable_manager.dart';
import '../utils/utils.dart';
import 'publish_args.dart';

class PublishCommand extends CliCommand<PublishArgs> {
  PublishCommand({
    required super.context,
    super.logger,
    this.processManager = const LocalProcessManager(),
    this.fileSystem = const LocalFileSystem(),
    this.zipEncoder = const ZipEncoder(),
    WidgetbookHttpClient? client,
  })  : _client = client ??
            WidgetbookHttpClient(
              environment: context.environment,
            ),
        super(
          name: 'publish',
          description: 'Publish a new build',
        ) {
    argParser
      ..addOption(
        'path',
        help: 'The path to the build folder of your application.',
        defaultsTo: './',
      )
      ..addOption(
        'api-key',
        help: 'The project specific API key for Widgetbook Cloud.',
        mandatory: true,
      )
      ..addOption(
        'branch',
        help: 'The name of the branch for which the Widgetbook is uploaded.',
      )
      ..addOption(
        'repository',
        help:
            'The name of the repository for which the Widgetbook is uploaded.',
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
        'base-branch',
        help: '[Deprecated: Use GitHub App instead]. '
            'The base branch of the pull-request. For example, main or master.',
      );
  }

  final ProcessManager processManager;
  final FileSystem fileSystem;
  final ZipEncoder zipEncoder;
  final WidgetbookHttpClient _client;
  late final Progress progress = logger.progress('Publishing Widgetbook');

  @override
  Future<PublishArgs> parseResults(Context context, ArgResults results) async {
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

    return PublishArgs(
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
  FutureOr<int> runWith(Context context, PublishArgs args) async {
    logger.warn(
      '⚠️ Deprecation Notice\n'
      'The `publish` command is deprecated and will be removed in the future.\n'
      'Use the `widgetbook cloud build push` command instead.\n'
      'For more information, '
      'see: https://docs.widgetbook.io/widgetbook-cloud/overview'
      '\n-------------------------------------------------------------\n',
    );

    try {
      if (context.repository == null) {
        GitDirectoryNotFound(
          message: 'Not a valid git directory.',
        );
      }

      final isValid = await validateRepository(context.repository!);

      if (!isValid) {
        progress.cancel();
        throw ExitedByUser();
      }

      progress.update('Getting versions');

      final lockPath = p.join(args.path, 'pubspec.lock');
      final versions = await VersionsMetadata.from(
        lockFile: fileSystem.file(lockPath),
        flutterVersionOutput: await processManager.runFlutter(['--version']),
      );

      logger.info('\nThe following versions are used: ');
      logger.info('  Flutter    : ${versions?.flutter ?? '-'}');
      logger.info('  Widgetbook : ${versions?.widgetbook ?? '-'}');
      logger.info('  Annotation : ${versions?.annotation ?? '-'}');
      logger.info('  Generator  : ${versions?.generator ?? '-'}');

      final buildResponse = await publishBuild(
        args: args,
        versions: versions,
      );

      progress.complete();
      logSuccess(
        baseUrl: context.environment.appUrl,
        projectId: buildResponse.project,
        buildId: buildResponse.build,
      );

      return ExitCode.success.code;
    } catch (e) {
      progress.fail();
      rethrow;
    }
  }

  /// Validates that the [repository] has no un-committed changes.
  /// Returns [true] if [repository] is clean or there is no terminal,
  /// otherwise the user is prompted to choose.
  Future<bool> validateRepository(Repository repository) async {
    final isClean = await repository.isClean;

    if (!isClean) {
      logger.warn('You have un-committed changes\n'
          'Uploading a new build to Widgetbook Cloud requires a commit '
          'SHA. Due to un-committed changes, we are using the commit SHA '
          'of your previous commit which can lead to the build being '
          'rejected due to an already existing build.');
    }

    return !isClean && stdin.hasTerminal
        ? logger.confirm('Would you like to proceed anyways?')
        : true; // clean or no terminal
  }

  Future<BuildResponse> publishBuild({
    required PublishArgs args,
    required VersionsMetadata? versions,
  }) async {
    final buildDirPath = p.join(args.path, 'build', 'web');
    final buildDir = fileSystem.directory(buildDirPath);

    if (!buildDir.existsSync()) {
      logger.err(
        'build/web directory does not exist.\n'
        'Run the following command before publishing:\n\n\t'
        'flutter build web --target path/to/widgetbook.dart\n\n',
      );

      throw UnableToCreateZipFileException();
    }

    progress.update('Generating zip');
    final encoder = zipEncoder;
    final zipFile = await encoder.zip(buildDir, 'web.zip');

    if (zipFile == null) {
      logger.err('Could not create .zip file.');
      throw UnableToCreateZipFileException();
    }

    progress.update('Uploading build');
    final response = await _client.uploadBuild(
      versions,
      BuildRequest(
        apiKey: args.apiKey,
        branchName: args.branch,
        repositoryName: args.repository,
        commitSha: args.commit,
        actor: args.actor,
        provider: args.vendor,
        file: zipFile,
      ),
    );

    for (final task in response.tasks) {
      if (task.status == UploadTaskStatus.success) {
        logger.success('\n✅ ${task.message}');
      } else if (task.status == UploadTaskStatus.warning) {
        logger.info('\n⚠️ ${task.message}');
      } else {
        logger.err('\n❌ ${task.message}');
      }
    }

    progress.complete('Build upload completed');

    return response;
  }

  void logSuccess({
    required String baseUrl,
    required String projectId,
    required String buildId,
  }) {
    final buildUrl = lightCyan.wrap(
      styleUnderlined.wrap(
        link(
          uri: Uri.parse(
            p.join(
              baseUrl,
              'projects/$projectId',
              'builds/$buildId',
            ),
          ),
        ),
      ),
    );

    logger.success('Successfully published to Widgetbook Cloud 🎉'
        '\n> Build: $buildUrl');
  }
}
