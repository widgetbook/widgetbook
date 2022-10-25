import 'dart:io';

import 'parser.dart';

class GitHubParser extends CiParser {
  GitHubParser({
    required super.argResults,
  });

  @override
  String get vendor => 'GitHub';

  @override
  Future<String?> getActor() async {
    return Platform.environment['GITHUB_ACTOR'];
  }

  @override
  Future<String?> getRepository() async {
    return Platform.environment['GITHUB_REPOSITORY'];
  }
}
