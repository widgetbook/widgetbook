import 'package:platform/platform.dart';

import 'ci_parser.dart';

class BitbucketParser extends CiParser {
  BitbucketParser({
    required super.argResults,
    this.platform = const LocalPlatform(),
  });

  final Platform platform;

  @override
  String get vendor => 'Bitbucket';

  /// The person who kicked off the build ( by doing a push, merge etc), and
  /// for scheduled builds, the uuid of the pipelines user.
  @override
  Future<String?> getActor() async {
    return platform.environment['BITBUCKET_STEP_TRIGGERER_UUID'];
  }

  @override
  Future<String?> getRepository() async {
    return platform.environment['BITBUCKET_REPO_FULL_NAME'];
  }
}
