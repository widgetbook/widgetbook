import 'package:platform/platform.dart';

import 'ci_parser.dart';

class GitHubParser extends CiParser {
  GitHubParser({
    required super.argResults,
    this.platform = const LocalPlatform(),
  });

  final Platform platform;

  @override
  String get vendor => 'GitHub';

  @override
  Future<String?> getActor() async {
    return platform.environment['GITHUB_ACTOR'];
  }

  @override
  Future<String?> getRepository() async {
    return platform.environment['GITHUB_REPOSITORY'];
  }
}
