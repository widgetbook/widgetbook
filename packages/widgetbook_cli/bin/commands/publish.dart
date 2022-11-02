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

import 'package:ci/ci.dart' as ci;
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:widgetbook_git/widgetbook_git.dart';

import './command.dart';
import '../api/widgetbook_http_client.dart';
import '../ci_parser/ci_parser_runner.dart';
import '../git-provider/github/github.dart';
import '../helpers/exceptions.dart';
import '../helpers/widgetbook_zip_encoder.dart';
import '../models/models.dart';
import '../review/devices/device_parser.dart';
import '../review/locales/locales_parser.dart';
import '../review/text_scale_factors/text_scale_factor_parser.dart';
import '../review/themes/theme_parser.dart';
import '../review/use_cases/models/changed_use_case.dart';
import '../review/use_cases/use_case_parser.dart';

class PublishCommand extends WidgetbookCommand {
  PublishCommand({super.logger, this.ciParserRunner}) {
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
        'git-provider',
        help: 'The name of the Git provider.',
        defaultsTo: 'Local',
        allowed: [
          'GitHub',
          'GitLab',
          'BitBucket',
          'Azure',
          'Local',
        ],
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

  late CiParserRunner? ciParserRunner;

  @override
  Future<int> run() async {
    final publishProgress = logger.progress(
      'Uploading build',
    );

    final path = results['path'] as String;

    if (!await GitDir.isGitDir(path)) {
      publishProgress.fail();
      usageException('Directory from "path" is not a Git folder');
    }

    final gitDir = await GitDir.fromExisting(
      path,
      allowSubdirectory: true,
    );

    publishProgress.update('Obtaining data from Git');

    final isWorkingTreeClean = await gitDir.isWorkingTreeClean();

    final apiKey = results['api-key'] as String;
    final currentBranch = await gitDir.currentBranch();
    final branch = results['branch'] as String? ?? currentBranch.branchName;

    final commit = results['commit'] as String? ?? currentBranch.sha;

    final gitProvider = results['git-provider'] as String;
    final gitHubToken = results['github-token'] as String?;
    final prNumber = results['pr'] as String?;

    final baseBranch = results['base-branch'] as String?;

    final ciArgsData = CliArgs(
      apiKey: apiKey,
      branch: branch,
      commit: commit,
      gitProvider: gitProvider,
      gitHubToken: gitHubToken,
      prNumber: prNumber,
      baseBranch: baseBranch,
      path: path,
    );

    ciParserRunner = CiParserRunner(
      argResults: results,
      gitDir: gitDir,
    );

    final ciArgs = await ciParserRunner?.getParser()?.getCiArgs();

    if (ciArgs == null) {
      publishProgress.fail();
      usageException(
        'Your CI/CD pipeline provider is currently not supported.',
      );
    }

    publishProgress.update('Checking commit');
    if (!isWorkingTreeClean) {
      logger
        ..warn('You have un-commited changes')
        ..warn(
            'Uploading a new build to Widgetbook Cloud requires a commit SHA. '
            'Due to un-committed changes, we are using the commit SHA '
            'of your previous commit which can lead to the build being '
            'rejected due to an already existing build.');

      final proceedWithUnCommitedChanges = logger.chooseOne(
        'Would you like to proceed anyways?',
        choices: ['no', 'yes'],
        defaultValue: 'no',
      );

      if (proceedWithUnCommitedChanges == 'no') {
        publishProgress.cancel();
        return ExitCode.success.code;
      } else {
        await _publishBuilds(
          cliArgs: ciArgsData,
          ciArgs: ciArgs,
          gitDir: gitDir,
          publishProgress: publishProgress,
        );
      }
    } else {
      await _publishBuilds(
        cliArgs: ciArgsData,
        ciArgs: ciArgs,
        gitDir: gitDir,
        publishProgress: publishProgress,
      );
    }

    return ExitCode.success.code;
  }

  void _deleteZip(File zip) {
    if (!ci.isCI) {
      zip.delete();
    }
  }

  Future<void> _publishBuilds({
    required CliArgs cliArgs,
    required CiArgs ciArgs,
    required GitDir gitDir,
    required Progress publishProgress,
  }) async {
    if (ciArgs.actor == null) {
      throw ActorNotFoundException();
    }

    if (ciArgs.repository == null) {
      throw RepositoryNotFoundException();
    }

    publishProgress.update('Getting branches');
    final branches = (await gitDir.branches()).toList();

    final branchExists = branches.any(
      (element) => element.branchName == cliArgs.baseBranch,
    );
    var baseCommit = results['base-commit'] as String?;

    if (branchExists) {
      baseCommit = branches
          .firstWhere(
            (element) => element.branchName == cliArgs.baseBranch,
          )
          .sha;
    }

    final buildPath = p.join(
      cliArgs.path,
      'build',
      'web',
    );

    final directory = Directory(buildPath);
    final useCases = cliArgs.baseBranch == null
        ? <ChangedUseCase>[]
        : await UseCaseParser(
            projectPath: cliArgs.path,
            baseBranch: cliArgs.baseBranch!,
          ).parse();
    final themes = await ThemeParser(projectPath: cliArgs.path).parse();
    final locales = await LocaleParser(projectPath: cliArgs.path).parse();
    final devices = await DeviceParser(projectPath: cliArgs.path).parse();
    final textScaleFactors =
        await TextScaleFactorParser(projectPath: cliArgs.path).parse();

    try {
      publishProgress.update('Generating zip');
      final file = WidgetbookZipEncoder().encode(directory);

      if (file != null) {
        publishProgress.update('Uploading build');
        final uploadInfo = await WidgetbookHttpClient().uploadDeployment(
          deploymentFile: file,
          data: DeploymentData(
            branchName: cliArgs.branch,
            repositoryName: ciArgs.repository!,
            commitSha: cliArgs.commit,
            actor: ciArgs.actor!,
            apiKey: cliArgs.apiKey,
            provider: ciArgs.vendor,
          ),
        );

        if (uploadInfo == null) {
          throw WidgetbookApiException();
        } else {
          publishProgress.complete('Uploaded build');
        }

        if (cliArgs.prNumber != null) {
          if (cliArgs.gitHubToken != null) {
            await GithubProvider(
              apiKey: cliArgs.gitHubToken!,
            ).addBuildComment(
              buildInfo: uploadInfo,
              number: cliArgs.prNumber!,
            );
          }
        }

        // If generator is not run or not properly configured
        if (themes.isEmpty) {
          logger.err(
            'HINT: Could not find generator files. '
            'Therefore, no review has been created. '
            'Make sure to use widgetbook_generator and '
            'run build_runner before this CLI. '
            'See https://docs.widgetbook.io/widgetbook-cloud/review for more '
            'information.',
          );
          throw FileNotFoundException(
            message: 'Could not find generator files. ',
          );
        }

        if (cliArgs.baseBranch != null && baseCommit != null) {
          publishProgress.update('Uploading review');
          try {
            await WidgetbookHttpClient().uploadReview(
              apiKey: cliArgs.apiKey,
              useCases: useCases,
              buildId: uploadInfo['build'] as String,
              projectId: uploadInfo['project'] as String,
              baseBranch: cliArgs.baseBranch!,
              baseSha: baseCommit,
              headBranch: cliArgs.branch,
              headSha: cliArgs.commit,
              themes: themes,
              locales: locales,
              devices: devices,
              textScaleFactors: textScaleFactors,
            );
            publishProgress.complete('Uploaded review');
          } catch (_) {
            throw WidgetbookApiException();
          }
        } else {
          logger.warn(
            'HINT: No pull-request information available. Therefore, '
            'no review will be created. See docs for more information.',
          );
        }

        _deleteZip(file);
      } else {
        logger.err('Could not create .zip file for upload.');
      }
    } catch (e) {
      publishProgress.fail();
      rethrow;
    }
  }
}
