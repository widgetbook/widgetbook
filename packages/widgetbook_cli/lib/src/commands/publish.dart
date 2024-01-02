import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:process/process.dart';
import 'package:yaml/yaml.dart';

import '../../metadata.dart';
import '../api/api.dart';
import '../core/core.dart';
import '../git/git.dart';
import '../models/changed_use_case.dart';
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
    this.useCaseReader = const UseCaseReader(),
    WidgetbookHttpClient? client,
  })  : _client = client ??
            WidgetbookHttpClient(
              environment: context.environment,
            ),
        super(
          name: 'publish',
          description: 'Publish a new build',
        ) {
    progress = logger.progress('Publishing Widgetbook');
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
        help:
            'The base branch of the pull-request. For example, main or master.',
      )
      ..addFlag(
        'experimental-visual-diff',
        negatable: false,
        help: 'Runs golden tests on Widgetbook Cloud to detect changes. '
            '(experimental ✨)',
      );
  }

  final ProcessManager processManager;
  final FileSystem fileSystem;
  final ZipEncoder zipEncoder;
  final UseCaseReader useCaseReader;
  final WidgetbookHttpClient _client;
  late final Progress progress;

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

    progress.update('finding base branch');
    final baseBranchName = results['base-branch'] as String?;
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

    final visualDiff = results['experimental-visual-diff'] != null;

    return PublishArgs(
      apiKey: apiKey,
      branch: branch,
      commit: commit,
      path: path,
      vendor: context.name,
      actor: actor,
      repository: repoName,
      baseBranch: baseBranch,
      visualDiff: visualDiff,
    );
  }

  @override
  FutureOr<int> runWith(Context context, PublishArgs args) async {
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

      final versions = await getVersions(args);
      logger.info('\nThe following versions are used: ');
      logger.info('  Flutter    : ${versions?.flutter ?? '-'}');
      logger.info('  Widgetbook : ${versions?.widgetbook ?? '-'}');
      logger.info('  Annotation : ${versions?.annotation ?? '-'}');
      logger.info('  Generator  : ${versions?.generator ?? '-'}');

      final buildResponse = await publishBuild(
        args: args,
        versions: versions,
      );

      if (!args.hasReview) {
        logger.info(
          '💡Tip: You can upload a review by specifying a `base-branch` option.\n'
          'For more information: https://docs.widgetbook.io/widgetbook-cloud/reviews',
        );
      }

      final reviewResponse = args.hasReview
          ? await publishReview(
              args: args,
              buildResponse: buildResponse,
              context: context,
              versions: versions,
            )
          : null;

      progress.complete();
      logSuccess(
        baseUrl: context.environment.appUrl,
        projectId: buildResponse.project,
        buildId: buildResponse.build,
        reviewId: reviewResponse?.review.id,
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
    final zipFile = await encoder.zip(buildDir);

    if (zipFile == null) {
      logger.err('Could not create .zip file.');
      throw UnableToCreateZipFileException();
    }

    progress.update('Uploading build');

    if (args.visualDiff) {
      logger.warn(
        tag: '',
        '\n\n✨ Experimental Visual Diff is enabled.\n'
        'This feature is still in development and might not work as expected.\n',
      );
    }

    final useCases = !args.visualDiff //
        ? null
        : await useCaseReader.read(args.path).then(
              (value) => value
                  .map(
                    (useCase) => ChangedUseCase.fromUseCase(
                      useCase: useCase,
                      modification: Modification.changed, // Redundant
                    ),
                  )
                  .toList(),
            );

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
        takeScreenshots: args.visualDiff,
        useCases: useCases,
        baseSha: args.baseBranch?.sha,
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

  Future<ReviewResponse?> publishReview({
    required Context context,
    required PublishArgs args,
    required BuildResponse buildResponse,
    required VersionsMetadata? versions,
  }) async {
    final genDirPath = p.join(args.path, '.dart_tool', 'build', 'generated');
    final genDir = fileSystem.directory(genDirPath);

    if (!genDir.existsSync()) {
      logger.err(
        'Could not find generator files. Therefore, no review has been created.\n'
        'Make sure to use widgetbook_generator and run build_runner before this CLI.\n'
        'For more information: https://docs.widgetbook.io/widgetbook-cloud/reviews',
      );

      throw ReviewNotFoundException();
    }

    final useCases = await useCaseReader.read(args.path);
    final reviewUseCases = args.visualDiff
        ? useCases
            .map(
              (useCase) => ChangedUseCase.fromUseCase(
                useCase: useCase,
                modification: Modification.changed, // Redundant
              ),
            )
            .toList()
        : useCaseReader.compare(
            useCases: useCases,
            diffs: await context.repository!.diff(args.baseBranch!.fullName),
          );

    if (reviewUseCases.isEmpty) {
      logger.err('Could not find any changed use-cases files.');
      throw ReviewNotFoundException();
    }

    progress.update(
      'Uploading ${reviewUseCases.length} use-case(s) for review',
    );

    final response = await _client.uploadReview(
      versions,
      ReviewRequest(
        apiKey: args.apiKey,
        useCases: reviewUseCases,
        buildId: buildResponse.build,
        projectId: buildResponse.project,
        baseBranch: args.baseBranch!.fullName,
        headBranch: args.branch,
        baseSha: args.baseBranch!.sha,
        headSha: args.commit,
        takeScreenshots: args.visualDiff,
      ),
    );

    progress.complete('Review upload completed');

    return response;
  }

  void logSuccess({
    required String baseUrl,
    required String projectId,
    required String buildId,
    required String? reviewId,
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

    final reviewUrl = lightCyan.wrap(
      styleUnderlined.wrap(
        link(
          uri: Uri.parse(
            p.join(
              baseUrl,
              'projects/$projectId',
              'reviews/$reviewId',
              'builds/$buildId',
              'use-cases',
            ),
          ),
        ),
      ),
    );

    logger.success(
      'Successfully published to Widgetbook Cloud 🎉'
      '\n> Build: $buildUrl'
      "${reviewId != null ? '\n> Review: $reviewUrl' : ''}",
    );
  }

  /// Gets metadata about the currently used versions of Flutter and
  /// all Widgetbook packages.
  Future<VersionsMetadata?> getVersions(PublishArgs args) async {
    try {
      final lockPath = p.join(args.path, 'pubspec.lock');
      final lockContent = await fileSystem.file(lockPath).readAsString();
      final lockFile = loadYaml(lockContent) as YamlMap;
      final packages = lockFile['packages'] as YamlMap;

      return VersionsMetadata(
        cli: packageVersion,
        flutter: await getFlutterVersion(),
        widgetbook: getPackageVersion(packages, 'widgetbook'),
        annotation: getPackageVersion(packages, 'widgetbook_annotation'),
        generator: getPackageVersion(packages, 'widgetbook_generator'),
      );
    } catch (_) {
      return null;
    }
  }

  Future<String?> getFlutterVersion() async {
    final result = await processManager.runFlutter(['--version']);
    final regex = RegExp(r'Flutter (\d+.\d+.\d+)');
    final match = regex.firstMatch(result);

    return match?.group(1);
  }

  String? getPackageVersion(YamlMap packages, String name) {
    final package = packages[name] as YamlMap?;
    return package?['version']?.toString();
  }
}
