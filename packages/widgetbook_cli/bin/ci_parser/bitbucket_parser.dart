import './ci_parser.dart';

class BitbucketParser extends CiParser {
  BitbucketParser({
    required super.argResults,
    PlatformWrapper? platformWrapper,
  }) : _platformWrapper = platformWrapper ?? PlatformWrapper();

  final PlatformWrapper _platformWrapper;

  PlatformWrapper get platformWrapper => _platformWrapper;

  @override
  String get vendor => 'Bitbucket';

  /// The person who kicked off the build ( by doing a push, merge etc), and
  /// for scheduled builds, the uuid of the pipelines user.
  @override
  Future<String?> getActor() async {
    return _platformWrapper.environmentVariable(
      variable: 'BITBUCKET_STEP_TRIGGERER_UUID',
    );
  }

  @override
  Future<String?> getRepository() async {
    return _platformWrapper.environmentVariable(
      variable: 'BITBUCKET_REPO_FULL_NAME',
    );
  }
}
