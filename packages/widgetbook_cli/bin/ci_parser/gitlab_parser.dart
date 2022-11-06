import './ci_parser.dart';

class GitLabParser extends CiParser {
  GitLabParser({
    required super.argResults,
    PlatformWrapper? platformWrapper,
  }) : _platformWrapper = platformWrapper ?? PlatformWrapper();

  final PlatformWrapper _platformWrapper;

  PlatformWrapper get platformWrapper => _platformWrapper;

  @override
  String get vendor => 'GitLab';

  @override
  Future<String?> getActor() async {
    return _platformWrapper.environmentVariable(variable: 'GITLAB_USER_NAME');
  }

  @override
  Future<String?> getRepository() async {
    return _platformWrapper.environmentVariable(variable: 'CI_PROJECT_NAME');
  }
}
