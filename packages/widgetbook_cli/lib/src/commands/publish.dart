import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;

import '../api/api.dart';
import '../core/core.dart';
import '../git/git.dart';
import '../utils/utils.dart';
import 'publish_args.dart';

class PublishCommand extends CliCommand<PublishArgs> {
  PublishCommand({
    required super.context,
    super.logger,
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
      ..addOption(
        'github-token',
        help: 'GitHub API token.',
      )
      ..addOption(
        'pr',
        help: 'The number of the PR.',
      );
  }

  final FileSystem fileSystem;
  final ZipEncoder zipEncoder;
  final UseCaseReader useCaseReader;
  final WidgetbookHttpClient _client;
  late final Progress progress;

  @override
  FutureOr<Context> overrideContext(Context context, ArgResults results) {
    final workingDir = results['path'] as String;

    return context.copyWith(
      workingDir: workingDir,
    );
  }

  @override
  Future<PublishArgs> parseResults(Context context, ArgResults results) async {
    final repository = context.repository;
    final path = results['path'] as String;
    final apiKey = results['api-key'] as String;
    final gitHubToken = results['github-token'] as String?;
    final prNumber = results['pr'] as String?;

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

    return PublishArgs(
      apiKey: apiKey,
      branch: branch,
      commit: commit,
      path: path,
      vendor: context.name,
      actor: actor,
      repository: repoName,
      baseBranch: baseBranch,
      prNumber: prNumber,
      gitHubToken: gitHubToken,
    );
  }

  @override
  FutureOr<int> runWith(Context context, PublishArgs args) async {
    try {
      final isValid = await validateRepository(context.repository);

      if (!isValid) {
        progress.cancel();
        throw ExitedByUser();
      }

      final buildResponse = await publishBuild(args);
      final hasReview = args.baseBranch != null;

      if (!hasReview) {
        logger.info(
          '💡Tip: You can upload a review by specifying a `base-branch` option.\n'
          'For more information: https://docs.widgetbook.io/widgetbook-cloud/reviews',
        );
      }

      final reviewResponse = hasReview
          ? await publishReview(
              args: args,
              buildResponse: buildResponse,
              context: context,
            )
          : null;

      if (args.prNumber != null && args.gitHubToken != null) {
        final githubClient = GitHubClient(
          apiKey: args.gitHubToken!,
        );

        await githubClient.postComment(
          repository: context.project!,
          prNumber: args.prNumber!,
          body: composeComment(
            baseUrl: context.environment.appUrl,
            projectId: buildResponse.project,
            buildId: buildResponse.build,
            reviewId: reviewResponse?.review.id,
          ),
        );
      }

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

  Future<BuildResponse> publishBuild(PublishArgs args) async {
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
    final response = await _client.uploadBuild(
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

  Future<ReviewResponse?> publishReview({
    required Context context,
    required PublishArgs args,
    required BuildResponse buildResponse,
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
    final diffs = await context.repository.diff(args.baseBranch!.fullName);

    final changeUseCases = useCaseReader.compare(
      useCases: useCases,
      diffs: diffs,
    );

    if (changeUseCases.isEmpty) {
      logger.err('Could not find any changed use-cases files.');
      throw ReviewNotFoundException();
    }

    progress.update(
      'Uploading review [${changeUseCases.length} modified use-case(s)]',
    );

    final response = await _client.uploadReview(
      ReviewRequest(
        apiKey: args.apiKey,
        useCases: changeUseCases,
        buildId: buildResponse.build,
        projectId: buildResponse.project,
        baseBranch: args.baseBranch!.fullName,
        headBranch: args.branch,
        baseSha: args.baseBranch!.sha,
        headSha: args.commit,
      ),
    );

    progress.complete('Review upload completed');

    return response;
  }

  String composeComment({
    required String baseUrl,
    required String projectId,
    required String buildId,
    required String? reviewId,
  }) {
    final buildUrl = p.join(
      baseUrl,
      'projects/$projectId',
      'builds/$buildId',
    );

    final reviewUrl = p.join(
      baseUrl,
      'projects/$projectId',
      'reviews/$reviewId',
      'builds/$buildId',
      'use-cases',
    );

    final buffer = StringBuffer(
      '### 📦 Build\n\n'
      '- 🔗 [Widgetbook Cloud - Build]($buildUrl)',
    );

    if (reviewId != null) {
      buffer.writeln(
        '\n\n'
        '### 📑 Review\n\n'
        '- 🔗 [Widgetbook Cloud - Review]($reviewUrl)',
      );
    }

    return buffer.toString();
  }
}
