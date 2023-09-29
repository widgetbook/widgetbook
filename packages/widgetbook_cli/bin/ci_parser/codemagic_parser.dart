import 'package:platform/platform.dart';

import 'ci_parser.dart';

class CodemagicParser extends CiParser {
  CodemagicParser({
    required super.argResults,
    this.platform = const LocalPlatform(),
  });

  final Platform platform;

  @override
  String get vendor => 'Codemagic';

  /// The person who kicked off the build ( by doing a push, merge etc), and
  /// for scheduled builds, the uuid of the pipelines user.
  @override
  Future<String?> getActor() async {
    return 'Codemagic';
  }

  @override
  Future<String?> getRepository() async {
    return platform.environment['CM_REPO_SLUG'];
  }
}
