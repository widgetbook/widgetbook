import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

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
      mandatory: true,
    )
    ..addOption(
      'api-key',
      help: 'The project specific API key for Widgetbook Cloud.',
      mandatory: true,
    )
    ..addOption(
      'branch',
      help: 'The name of the branch for which the Widgetbook is uploaded.',
      mandatory: true,
    )
    ..addOption(
      'repository',
      help: 'The name of the repository for which the Widgetbook is uploaded.',
      mandatory: true,
    )
    ..addOption(
      'commit',
      help: 'The SHA hash of the commit for which the Widgetbook is uploaded.',
      mandatory: true,
    )
    ..addOption(
      'actor',
      help: 'The username of the actor which triggered the build.',
      mandatory: true,
    )
    ..addOption(
      'git-provider',
      help: 'The name of the Git provider.',
      mandatory: true,
      allowed: [
        'GitHub',
        'GitLab',
        'BitBucket',
        'Azure',
        // CLI is for users running the command locally.
        'CLI',
      ],
    )
    ..addOption(
      'base-branch',
      help: 'The base branch of the pull-request. For example, main or master.',
    )
    ..addOption(
      'base-commit',
      help: 'The SHA hash of the commit of the base branch.',
    );

  final args = parser.parse(arguments);

  final path = args['path'] as String;
  final apiKey = args['api-key'] as String;
  final branch = args['branch'] as String;
  final repository = args['repository'] as String;
  final commit = args['commit'] as String;
  final actor = args['actor'] as String;
  final gitProvider = args['git-provider'] as String;

  final baseBranch = args['base-branch'] as String?;
  final baseCommit = args['base-commit'] as String?;

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
      ),
    );

    if (uploadInfo != null &&
        baseBranch != null &&
        baseCommit != null &&
        // If a review shall be created, the projects needs to use generator
        // Generator requires to define at least one theme.
        themes.isNotEmpty) {
      await WidgetbookHttpClient().uploadReview(
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
    } else {
      print(
        'HINT: No pull-request information available. Therefore, no review will'
        ' be created. See docs for more information.',
      );
    }
  } else {
    print('Could not create .zip file for upload.');
  }
}
