import 'package:args/args.dart';
import 'package:ci/ci.dart' as ci;
import 'package:widgetbook_git/widgetbook_git.dart';

import 'ci_parser.dart';
import 'local_parser.dart';

class CiParserRunner {
  CiParserRunner({
    required this.argResults,
    required this.gitDir,
  });

  final ArgResults argResults;
  final GitDir gitDir;

  CiParser? getParser() {
    if (!ci.isCI) {
      return LocalParser(
        argResults: argResults,
        gitDir: gitDir,
      );
    }
    if (ci.Vendor.IS_GITLAB) {
      return GitLabParser(argResults: argResults);
    }
    if (ci.Vendor.IS_GITHUB_ACTIONS) {
      return GitHubParser(argResults: argResults);
    }
    if (ci.Vendor.IS_AZURE_PIPELINES) {
      return AzureParser(argResults: argResults);
    }
    if (ci.Vendor.IS_BITBUCKET) {
      return BitbucketParser(argResults: argResults);
    }

    return null;
  }
}
