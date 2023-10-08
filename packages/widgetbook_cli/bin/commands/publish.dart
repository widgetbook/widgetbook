import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import '../api/api.dart';
import '../core/cli_command.dart';
import '../core/context.dart';
import '../git-provider/github/github.dart';
import '../git/reference.dart';
import '../git/repository.dart';
import '../helpers/exceptions.dart';
import '../helpers/zip_encoder.dart';
import '../review/use_case_reader.dart';
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
    final path = results['path'] as String;
    final apiKey = results['api-key'] as String;
    final gitHubToken = results['github-token'] as String?;
    final prNumber = results['pr'] as String?;

    final currentBranch = await context.repository.currentBranch;
    final branch = results['branch'] as String? ?? currentBranch.name;
    final commit = results['commit'] as String? ??
        context.providerSha ??
        currentBranch.sha;

    final baseBranch = await getBaseBranch(
      repository: context.repository,
      branch: results['base-branch'] as String?,
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
      baseBranch: baseBranch?.fullName,
      baseSha: baseBranch?.sha,
      prNumber: prNumber,
      gitHubToken: gitHubToken,
    );
  }

  @override
  FutureOr<int> runWith(Context context, PublishArgs args) async {
    try {
      final isClean = await context.repository.isClean;
      final shouldContinue = isClean ? true : promptUncommittedChanges();

      if (!shouldContinue) {
        progress.cancel();
        throw ExitedByUser();
      }

      final buildResponse = await publishBuild(args);
      final hasReview = args.baseBranch != null && args.baseSha != null;

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
        await GithubProvider(
          apiKey: args.gitHubToken!,
          environment: context.environment,
        ).addBuildComment(
          number: args.prNumber!,
          projectId: buildResponse.project,
          buildId: buildResponse.build,
          reviewId: reviewResponse?.review.id,
        );
      }

      return ExitCode.success.code;
    } catch (e) {
      progress.fail();
      rethrow;
    }
  }

  @visibleForTesting
  bool promptUncommittedChanges() {
    logger
      ..warn('You have un-committed changes')
      ..warn('Uploading a new build to Widgetbook Cloud requires a commit '
          'SHA. Due to un-committed changes, we are using the commit SHA '
          'of your previous commit which can lead to the build being '
          'rejected due to an already existing build.');

    final result = stdin.hasTerminal
        ? logger.chooseOne(
            'Would you like to proceed anyways?',
            choices: ['no', 'yes'],
            defaultValue: 'no',
          )
        : 'yes';

    return result == 'yes';
  }

  // TODO sha is pretty much not used an is just being overriden with the most
  // recent sha of the branch
  // If this will be included do we need to check if the sha exists on the
  // branch?
  @visibleForTesting
  Future<Reference?> getBaseBranch({
    required Repository repository,
    required String? branch,
  }) async {
    if (branch == null) {
      return null;
    }

    progress.update('fetching remote branches');
    await repository.fetch();

    progress.update('reading existing branches');
    final branches = await repository.branches;
    final branchesMap = {
      for (var k in branches) k.fullName: k,
    };

    final branchRef = Reference(
      // This is not used, we are just using BranchReference to check if this is
      // a heads or remote branch (if at all)
      'a' * 40,
      branch,
    );

    const headsPrefix = 'refs/heads/';
    const headsPrefixRegex = '(?<=$headsPrefix)';
    const remotesPrefix = 'refs/remotes/origin/';
    const remotesPrefixRegex = '(?<=$remotesPrefix)';
    const endOfLine = r'$';

    if (branchRef.isHead || branchRef.isRemote) {
      if (branchesMap.containsKey(branchRef.fullName)) {
        return branchesMap[branchRef.fullName];
      }

      // Azure provides the ref as 'refs/heads/<branch-name>'
      // This branch won't be found as of default.
      // But a branch 'refs/remotes/origin/<branch-name>' will exist
      final headsRefAsRemoteRef = '$remotesPrefix${branchRef.name}';
      if (branchesMap.containsKey(headsRefAsRemoteRef)) {
        return branchesMap[headsRefAsRemoteRef];
      }

      return null;
    } else {
      final headsRegex = RegExp(
        '$headsPrefixRegex${branchRef.fullName}$endOfLine',
      );
      final remotesRegex = RegExp(
        '$remotesPrefixRegex${branchRef.fullName}$endOfLine',
      );
      for (final branch in branches) {
        if (headsRegex.hasMatch(branch.fullName)) {
          return branch;
        }
      }

      for (final branch in branches) {
        if (remotesRegex.hasMatch(branch.fullName)) {
          return branch;
        }
      }
    }

    return null;
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
    final diffs = await context.repository.diff(args.baseBranch!);

    final changeUseCases = await useCaseReader.compare(
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
        baseBranch: args.baseBranch!,
        headBranch: args.branch,
        baseSha: args.baseSha!,
        headSha: args.commit,
      ),
    );

    progress.complete('Review upload completed');

    return response;
  }
}
