import 'package:args/args.dart';
import 'package:widgetbook_git/widgetbook_git.dart';

import './ci_parser.dart';

class CiParserRunner {
  CiParserRunner({
    required this.argResults,
    required this.gitDir,
    CiWrapper? ciWrapper,
    PlatformWrapper? platformWrapper,
  })  : _ciWrapper = ciWrapper ?? CiWrapper(),
        _platformWrapper = platformWrapper ?? PlatformWrapper();

  final ArgResults argResults;
  final GitDir gitDir;

  final CiWrapper _ciWrapper;
  final PlatformWrapper _platformWrapper;

  PlatformWrapper get platformWrapper => _platformWrapper;

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
        platformWrapper: _platformWrapper,
      );
    }
    if (_ciWrapper.isGithub()) {
      return GitHubParser(
        argResults: argResults,
        platformWrapper: _platformWrapper,
      );
    }
    if (_ciWrapper.isAzure()) {
      return AzureParser(
        argResults: argResults,
        platformWrapper: _platformWrapper,
      );
    }
    if (_ciWrapper.isBitBucket()) {
      return BitbucketParser(
        argResults: argResults,
        platformWrapper: _platformWrapper,
      );
    }

    return null;
  }
}
