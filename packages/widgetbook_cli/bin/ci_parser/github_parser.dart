import './ci_parser.dart';

class GitHubParser extends CiParser {
  GitHubParser({
    required super.argResults,
    PlatformWrapper? platformWrapper,
  }) : _platformWrapper = platformWrapper ?? PlatformWrapper();

  final PlatformWrapper _platformWrapper;

  PlatformWrapper get platformWrapper => _platformWrapper;

  @override
  String get vendor => 'GitHub';

  @override
  Future<String?> getActor() async {
    return _platformWrapper.environmentVariable(variable: 'GITHUB_ACTOR');
  }

  @override
  Future<String?> getRepository() async {
    return _platformWrapper.environmentVariable(variable: 'GITHUB_REPOSITORY');
  }
}
