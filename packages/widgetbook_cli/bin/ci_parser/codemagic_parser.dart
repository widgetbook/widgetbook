import 'ci_parser.dart';

class CodemagicParser extends CiParser {
  CodemagicParser({
    required super.argResults,
    PlatformWrapper? platformWrapper,
  }) : _platformWrapper = platformWrapper ?? PlatformWrapper();

  final PlatformWrapper _platformWrapper;

  PlatformWrapper get platformWrapper => _platformWrapper;

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
    return _platformWrapper.environmentVariable(
      variable: 'CM_REPO_SLUG',
    );
  }
}
