import './ci_parser.dart';

class AzureParser extends CiParser {
  AzureParser({
    required super.argResults,
    PlatformWrapper? platformWrapper,
  }) : _platformWrapper = platformWrapper ?? PlatformWrapper();

  final PlatformWrapper _platformWrapper;

  PlatformWrapper get platformWrapper => _platformWrapper;

  @override
  String get vendor => 'Azure';

  @override
  Future<String?> getActor() async {
    return _platformWrapper.environmentVariable(variable: 'Agent.Name');
  }

  @override
  Future<String?> getRepository() async {
    return _platformWrapper.environmentVariable(
      variable: 'Build.Repository.Name',
    );
  }
}
