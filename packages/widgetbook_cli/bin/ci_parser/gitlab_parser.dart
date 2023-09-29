import 'package:platform/platform.dart';

import 'ci_parser.dart';

class GitLabParser extends CiParser {
  GitLabParser({
    required super.argResults,
    this.platform = const LocalPlatform(),
  });

  final Platform platform;

  @override
  String get vendor => 'GitLab';

  @override
  Future<String?> getActor() async {
    return platform.environment['GITLAB_USER_NAME'];
  }

  @override
  Future<String?> getRepository() async {
    return platform.environment['CI_PROJECT_NAME'];
  }
}
