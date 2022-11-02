import 'dart:io';

import './ci_parser.dart';

class GitLabParser extends CiParser {
  GitLabParser({
    required super.argResults,
  });

  @override
  String get vendor => 'GitLab';

  @override
  Future<String?> getActor() async {
    return Platform.environment['GITLAB_USER_NAME'];
  }

  @override
  Future<String?> getRepository() async {
    return Platform.environment['CI_PROJECT_NAME'];
  }
}
