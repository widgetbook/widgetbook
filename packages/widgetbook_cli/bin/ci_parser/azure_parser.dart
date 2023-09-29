import 'package:platform/platform.dart';

import 'ci_parser.dart';

class AzureParser extends CiParser {
  AzureParser({
    required super.argResults,
    this.platform = const LocalPlatform(),
  });

  final Platform platform;

  @override
  String get vendor => 'Azure';

  @override
  Future<String?> getActor() async {
    return platform.environment['Agent.Name'];
  }

  @override
  Future<String?> getRepository() async {
    return platform.environment['Build.Repository.Name'];
  }
}
