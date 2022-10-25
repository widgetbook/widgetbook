import 'dart:io';

import 'ci_parser.dart';

class BitbucketParser extends CiParser {
  BitbucketParser({
    required super.argResults,
  });

  @override
  String get vendor => 'GitLab';

  /// The person who kicked off the build ( by doing a push, merge etc), and
  /// for scheduled builds, the uuid of the pipelines user.
  @override
  Future<String?> getActor() async {
    return Platform.environment['BITBUCKET_STEP_TRIGGERER_UUID'];
  }

  @override
  Future<String?> getRepository() async {
    return Platform.environment['BITBUCKET_REPO_FULL_NAME'];
  }
}
