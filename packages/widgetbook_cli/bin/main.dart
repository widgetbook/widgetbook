import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:widgetbook_git/widgetbook_git.dart';

import 'git-provider/github/github.dart';
import 'models/deployment_data.dart';
import 'review/devices/device_parser.dart';
import 'review/locales/locales_parser.dart';
import 'review/text_scale_factors/text_scale_factor_parser.dart';
import 'review/themes/theme_parser.dart';
import 'review/use_cases/user_case_parser.dart';
import 'widgetbook_http_client.dart';
import 'widgetbook_zip_encoder.dart';

void main(List<String> arguments) async {
  final parser = ArgParser();
  parser
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Prints this information',
      callback: (isEnabled) {
        if (isEnabled) {
          print(parser.usage);
          exit(64);
        }
      },
    )
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
      help: 'The name of the repository for which the Widgetbook is uploaded.',
      mandatory: true,
    )
    ..addOption(
      'commit',
      help: 'The SHA hash of the commit for which the Widgetbook is uploaded.',
    )
    ..addOption(
      'actor',
      help: 'The username of the actor which triggered the build.',
      mandatory: true,
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
        // CLI is for users running the command locally.
        'Local',
      ],
    )
    ..addOption(
      'base-branch',
      help: 'The base branch of the pull-request. For example, main or master.',
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

  final args = parser.parse(arguments);

  final path = args['path'] as String;

  if (!await GitDir.isGitDir(path)) {
    print('Directory from "path" is not a Git folder');
    return;
  }

  final gitDir = await GitDir.fromExisting(
    path,
    allowSubdirectory: true,
  );

  final apiKey = args['api-key'] as String;
  final currentBranch = await gitDir.currentBranch();
  final branch = args['branch'] as String? ?? currentBranch.branchName;
  final repository = args['repository'] as String;
  final commit = args['commit'] as String? ?? currentBranch.sha;
  final actor = args['actor'] as String;
  final gitProvider = args['git-provider'] as String;
  final gitHubToken = args['github-token'] as String?;
  final prNumber = args['pr'] as String?;

  final baseBranch = args['base-branch'] as String?;
  final branches = (await gitDir.branches()).toList();
  final branchExists = baseBranch != null &&
      branches.any(
        (element) => element.branchName == baseBranch,
      );
  var baseCommit = args['base-commit'] as String?;

  if (branchExists) {
    baseCommit = branches
        .firstWhere(
          (element) => element.branchName == baseBranch,
        )
        .sha;
  }

  final buildPath = p.join(
    path,
    'build',
    'web',
  );

  final directory = Directory(buildPath);
  final useCases = await UseCaseParser(projectPath: path).parse();
  final themes = await ThemeParser(projectPath: path).parse();
  final locales = await LocaleParser(projectPath: path).parse();
  final devices = await DeviceParser(projectPath: path).parse();
  final textScaleFactors =
      await TextScaleFactorParser(projectPath: path).parse();
  final file = WidgetbookZipEncoder().encode(directory);
  if (file != null) {
    final uploadInfo = await WidgetbookHttpClient().uploadDeployment(
      deploymentFile: file,
      data: DeploymentData(
        branchName: branch,
        repositoryName: repository,
        commitSha: commit,
        actor: actor,
        apiKey: apiKey,
        provider: gitProvider,
        themes: themes,
        locales: locales,
        devices: devices,
        textScaleFactors: textScaleFactors,
      ),
    );

    // If generator is not run or not properly configured
    if (themes.isEmpty) {
      print(
        'HINT: Could not find generator files. '
        'Therefore, no review has been created. '
        'Make sure to use widgetbook_generator and '
        'run build_runner before this CLI. '
        'See https://docs.widgetbook.io/widgetbook-cloud/review for more '
        'information.',
      );
      exit(0);
    }

    if (uploadInfo != null && baseBranch != null && baseCommit != null) {
      final review = await WidgetbookHttpClient().uploadReview(
        apiKey: apiKey,
        useCases: useCases,
        buildId: uploadInfo['build'] as String,
        projectId: uploadInfo['project'] as String,
        baseBranch: baseBranch,
        baseSha: baseCommit,
        headBranch: branch,
        headSha: commit,
        themes: themes,
        locales: locales,
        devices: devices,
        textScaleFactors: textScaleFactors,
      );
      if (prNumber != null) {
        if (gitHubToken != null) {
          await GithubProvider(
            apiKey: gitHubToken,
          ).addBuildComment(
            buildInfo: uploadInfo,
            number: prNumber,
            review: review,
          );
        }
      }
    } else {
      // Refactor this
      if (uploadInfo != null && prNumber != null) {
        if (gitHubToken != null) {
          await GithubProvider(
            apiKey: gitHubToken,
          ).addBuildComment(
            buildInfo: uploadInfo,
            number: prNumber,
          );
        }
      }
      print(
        'HINT: No pull-request information available. Therefore, no review will'
        ' be created. See docs for more information.',
      );
    }
  } else {
    print('Could not create .zip file for upload.');
  }
}
