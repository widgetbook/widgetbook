import 'package:args/args.dart';
import 'package:platform/platform.dart';

import '../git/git_dir.dart';
import 'ci_parser.dart';

class CiParserRunner {
  CiParserRunner({
    required this.argResults,
    required this.gitDir,
    this.platform = const LocalPlatform(),
    CiWrapper? ciWrapper,
  }) : _ciWrapper = ciWrapper ?? CiWrapper();

  final ArgResults argResults;
  final GitDir gitDir;
  final Platform platform;
  final CiWrapper _ciWrapper;

  CiParser? getParser() {
    if (!_ciWrapper.isCI()) {
      return LocalParser(
        argResults: argResults,
        gitDir: gitDir,
      );
    }

    if (_ciWrapper.isGitLab()) {
      return GitLabParser(
        argResults: argResults,
        platform: platform,
      );
    }
    if (_ciWrapper.isGithub()) {
      return GitHubParser(
        argResults: argResults,
        platform: platform,
      );
    }
    if (_ciWrapper.isAzure()) {
      return AzureParser(
        argResults: argResults,
        platform: platform,
      );
    }
    if (_ciWrapper.isBitBucket()) {
      return BitbucketParser(
        argResults: argResults,
        platform: platform,
      );
    }
    if (_ciWrapper.isCodemagic()) {
      return CodemagicParser(
        argResults: argResults,
        platform: platform,
      );
    }

    return null;
  }
}
