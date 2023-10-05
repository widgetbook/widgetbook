// The MIT License (MIT)
// Copyright (c) 2022 Widgetbook GmbH
// Copyright (c) 2022 Felix Angelov

// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:

// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
// USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:io';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import '../api/api.dart';
import '../context/context.dart';
import '../context/context_manager.dart';
import '../git-provider/github/github.dart';
import '../git/git_manager.dart';
import '../git/repository.dart';
import '../helpers/exceptions.dart';
import '../helpers/zip_encoder.dart';
import '../models/models.dart';
import '../review/use_case_reader.dart';
import 'command.dart';

class PublishCommand extends WidgetbookCommand {
  PublishCommand({
    super.logger,
    this.fileSystem = const LocalFileSystem(),
    this.gitManager = const GitManager(),
    this.contextManager = const ContextManager(),
    UseCaseReader? useCaseReader,
    WidgetbookHttpClient? client,
  })  : useCaseReader = useCaseReader ??
            UseCaseReader(
              fileSystem: fileSystem,
            ),
        _client = client ?? WidgetbookHttpClient() {
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

  @override
  final String description = 'Publish a new build';

  @override
  final String name = 'publish';

  final FileSystem fileSystem;
  final GitManager gitManager;
  final UseCaseReader useCaseReader;
  final ContextManager contextManager;
  final WidgetbookHttpClient _client;
  late final Progress progress;

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

  @visibleForTesting
  Future<PublishArgs> getArguments({
    required Context context,
    required Repository repository,
  }) async {
    final path = results['path'] as String;
    final apiKey = results['api-key'] as String;
    final gitHubToken = results['github-token'] as String?;
    final prNumber = results['pr'] as String?;

    final currentBranch = await repository.currentBranch;
    final branch = results['branch'] as String? ?? currentBranch.name;
    final commit = results['commit'] as String? ??
        context.providerSha ??
        currentBranch.sha;

    // Fetch is needed because on most CI vendors, a shallow clone is used.
    // For example, on GitHub Actions, the base-branch will be $GITHUB_BASE_REF,
    // which resolves to "<branch-name>", but "refs/heads/<branch-name>" will
    // not be found with git show-ref. After running git fetch, the ref
    // "refs/remotes/origin/<branch-name>" will be found.
    await repository.fetch();
    final baseBranch = results['base-branch'] == null
        ? null
        : await repository.findRef(
            results['base-branch'] as String,
          );

    final actor = results['actor'] as String? ?? context.userName;
    if (actor == null) {
      throw ActorNotFoundException();
    }

    final repoName = results['repository'] as String? ?? context.repoName;
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
  Future<int> run() async {
    final path = results['path'] as String;
    final repository = gitManager.load(path);
    final isClean = await repository.isClean;
    final shouldContinue = isClean ? true : promptUncommittedChanges();

    if (!shouldContinue) {
      progress.cancel();
      throw ExitedByUser();
    }

    final context = await contextManager.load(repository);
    if (context == null) {
      throw CiVendorNotSupported();
    }

    final args = await getArguments(
      context: context,
      repository: repository,
    );

    await publish(
      args: args,
      repository: repository,
    );

    return ExitCode.success.code;
  }

  @visibleForTesting
  Future<void> publish({
    required PublishArgs args,
    required Repository repository,
  }) async {
    try {
      final buildResponse = await publishBuild(
        args: args,
      );

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
              repository: repository,
            )
          : null;

      if (args.prNumber != null && args.gitHubToken != null) {
        await GithubProvider(
          apiKey: args.gitHubToken!,
        ).addBuildComment(
          number: args.prNumber!,
          projectId: buildResponse.project,
          buildId: buildResponse.build,
          reviewId: reviewResponse?.review.id,
        );
      }
    } catch (e) {
      progress.fail();
      rethrow;
    }
  }

  Future<BuildResponse> publishBuild({
    required PublishArgs args,
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
    final encoder = ZipEncoder(fileSystem: fileSystem);
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
    required PublishArgs args,
    required BuildResponse buildResponse,
    required Repository repository,
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
    final diffs = await repository.diff(args.baseBranch!.fullName);

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
        baseBranch: args.baseBranch!.fullName,
        headBranch: args.branch,
        baseSha: args.baseBranch!.sha,
        headSha: args.commit,
      ),
    );

    progress.complete('Review upload completed');

    return response;
  }
}
