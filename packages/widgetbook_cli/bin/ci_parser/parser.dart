import 'package:args/args.dart';

import '../helpers/helpers.dart';
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
    return CiArgs(
      vendor: vendor,
      actor: argResults.hasActor ? argResults.actor : await getActor(),
      repository: argResults.hasRepository
          ? argResults.repository
          : await getRepository(),
    );
  }
}
