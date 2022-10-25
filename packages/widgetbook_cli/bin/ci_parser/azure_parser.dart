import 'dart:io';

import 'ci_parser.dart';

class AzureParser extends CiParser {
  AzureParser({
    required super.argResults,
  });

  @override
  String get vendor => 'Azure';

  @override
  Future<String?> getActor() async {
    return Platform.environment['Agent.Name'];
  }

  @override
  Future<String?> getRepository() async {
    return Platform.environment['Build.Repository.Name'];
  }
}
