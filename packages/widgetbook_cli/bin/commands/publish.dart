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
import 'package:platform/platform.dart';

import '../api/api.dart';
import '../ci_parser/ci_parser.dart';
import '../git-provider/github/github.dart';
import '../git/branch_reference.dart';
import '../git/git_dir.dart';
import '../git/git_wrapper.dart';
import '../helpers/exceptions.dart';
import '../helpers/zip_encoder.dart';
import '../models/models.dart';
import '../review/use_case_reader.dart';
import 'command.dart';

class PublishCommand extends WidgetbookCommand {
  PublishCommand({
    super.logger,
    this.ciParserRunner,
    this.platform = const LocalPlatform(),
    this.fileSystem = const LocalFileSystem(),
    UseCaseReader? useCaseReader,
    WidgetbookHttpClient? client,
    CiWrapper? ciWrapper,
    GitWrapper? gitWrapper,
  })  : useCaseReader = useCaseReader ??
            UseCaseReader(
              fileSystem: fileSystem,
            ),
        _client = client ?? WidgetbookHttpClient(),
        _ciWrapper = ciWrapper ?? CiWrapper(),
        _gitWrapper = gitWrapper ?? GitWrapper() {
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
        'base-commit',
        help: 'The SHA hash of the commit of the base branch.',
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

  CiParserRunner? ciParserRunner;
  final Platform platform;
  final FileSystem fileSystem;
  final UseCaseReader useCaseReader;
  final WidgetbookHttpClient _client;
  final CiWrapper _ciWrapper;
  final GitWrapper _gitWrapper;
  late final Progress progress;

  @visibleForTesting
  Future<void> checkIfPathIsGitDirectory(String path) async {
    final isGitDir = await _gitWrapper.isGitDir(path);
    if (!isGitDir) {
      throw GitDirectoryNotFound();
    }
  }

  @visibleForTesting
  Future<GitDir> getGitDir(String path) {
    return _gitWrapper.fromExisting(
      path,
      allowSubdirectory: true,
    );
  }

  @visibleForTesting
  Future<void> checkIfWorkingTreeIsClean(
    GitDir gitDir,
  ) async {
    final isWorkingTreeClean = await gitDir.isWorkingTreeClean();
    if (!isWorkingTreeClean) {
      logger
        ..warn('You have un-committed changes')
        ..warn('Uploading a new build to Widgetbook Cloud requires a commit '
            'SHA. Due to un-committed changes, we are using the commit SHA '
            'of your previous commit which can lead to the build being '
            'rejected due to an already existing build.');

      var proceedWithUnCommittedChanges = 'yes';

      if (stdin.hasTerminal) {
        proceedWithUnCommittedChanges = logger.chooseOne(
          'Would you like to proceed anyways?',
          choices: ['no', 'yes'],
          defaultValue: 'no',
        );
      }

      if (proceedWithUnCommittedChanges == 'no') {
        progress.cancel();
        throw ExitedByUser();
      }
    }
  }

  @visibleForTesting
  Future<CiArgs> getArgumentsFromCi(GitDir gitDir) async {
    // Due to the fact that the CiParserRunner requires a gitDir to be
    // initialized, we have this implementation to make the code testable
    ciParserRunner ??= CiParserRunner(argResults: results, gitDir: gitDir);
    final args = await ciParserRunner!.getParser()?.getCiArgs();

    if (args == null) {
      throw CiVendorNotSupported();
    }

    return args;
  }

  @visibleForTesting
  String? gitProviderSha() {
    if (_ciWrapper.isGithub()) {
      return platform.environment['GITHUB_SHA'];
    }

    if (_ciWrapper.isCodemagic()) {
      return platform.environment['CM_COMMIT'];
    }

    return null;
  }

  @visibleForTesting
  Future<PublishArgs> getArguments({
    required GitDir gitDir,
  }) async {
    final path = results['path'] as String;
    final apiKey = results['api-key'] as String;
    final currentBranch = await gitDir.currentBranch();
    final branch = results['branch'] as String? ?? currentBranch.branchName;

    final commit =
        results['commit'] as String? ?? gitProviderSha() ?? currentBranch.sha;

    final gitHubToken = results['github-token'] as String?;
    final prNumber = results['pr'] as String?;

    final baseBranch = await getBaseBranch(
      gitDir: gitDir,
      branch: results['base-branch'] as String?,
      sha: results['base-commit'] as String?,
    );

    final ciArgs = await getArgumentsFromCi(gitDir);
    final actor = ciArgs.actor;

    if (actor == null) {
      throw ActorNotFoundException();
    }

    final repository = ciArgs.repository;
    if (repository == null) {
      throw RepositoryNotFoundException();
    }

    return PublishArgs(
      apiKey: apiKey,
      branch: branch,
      commit: commit,
      path: path,
      vendor: ciArgs.vendor,
      actor: actor,
      repository: repository,
      baseBranch: baseBranch?.reference,
      baseSha: baseBranch?.sha,
      prNumber: prNumber,
      gitHubToken: gitHubToken,
    );
  }

  @override
  Future<int> run() async {
    final path = results['path'] as String;

    await checkIfPathIsGitDirectory(path);
    final gitDir = await getGitDir(path);
    await checkIfWorkingTreeIsClean(gitDir);
    final args = await getArguments(gitDir: gitDir);

    await publish(
      args: args,
      gitDir: gitDir,
    );

    return ExitCode.success.code;
  }

  // TODO sha is pretty much not used an is just being overriden with the most
  // recent sha of the branch
  // If this will be included do we need to check if the sha exists on the
  // branch?
  @visibleForTesting
  Future<BranchReference?> getBaseBranch({
    required GitDir gitDir,
    required String? branch,
    required String? sha,
  }) async {
    if (branch == null) {
      return null;
    }

    progress.update('fetching remote branches');
    await gitDir.fetch();

    progress.update('reading existing branches');
    final branches = await gitDir.allBranches();
    final branchesMap = {
      for (var k in branches) k.reference: k,
    };

    final branchRef = BranchReference(
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

    if (branchRef.isHeads || branchRef.isRemote) {
      if (branchesMap.containsKey(branchRef.reference)) {
        return branchesMap[branchRef.reference];
      }

      // Azure provides the ref as 'refs/heads/<branch-name>'
      // This branch won't be found as of default.
      // But a branch 'refs/remotes/origin/<branch-name>' will exist
      final headsRefAsRemoteRef = '$remotesPrefix${branchRef.branchName}';
      if (branchesMap.containsKey(headsRefAsRemoteRef)) {
        return branchesMap[headsRefAsRemoteRef];
      }

      return null;
    } else {
      final headsRegex = RegExp(
        '$headsPrefixRegex${branchRef.reference}$endOfLine',
      );
      final remotesRegex = RegExp(
        '$remotesPrefixRegex${branchRef.reference}$endOfLine',
      );
      for (final branch in branches) {
        if (headsRegex.hasMatch(branch.reference)) {
          return branch;
        }
      }

      for (final branch in branches) {
        if (remotesRegex.hasMatch(branch.reference)) {
          return branch;
        }
      }
    }

    return null;
  }

  @visibleForTesting
  Future<void> publish({
    required PublishArgs args,
    required GitDir gitDir,
  }) async {
    try {
      final buildResponse = await publishBuild(
        args: args,
      );

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
              gitDir: gitDir,
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
    required GitDir gitDir,
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
    final diffs = await gitDir.diff(args.baseBranch!);

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
