import 'package:args/args.dart';

import '../models/models.dart';

abstract class CiParser {
  const CiParser({
    required this.argResults,
  });

  Future<String?> getActor();
  Future<String?> getRepository();
  String get vendor;

  final ArgResults argResults;

  Future<CiArgs> getCiArgs() async {
    final actor = argResults['actor'] == null
        ? await getActor()
        : argResults['actor'] as String;

    final repository = argResults['repository'] == null
        ? await getRepository()
        : argResults['repository'] as String;

    return CiArgs(
      vendor: vendor,
      actor: actor,
      repository: repository,
    );
  }
}
