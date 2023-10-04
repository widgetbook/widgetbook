import '../git/repository.dart';
import 'ci_parser.dart';

class LocalParser extends CiParser {
  LocalParser({
    required super.argResults,
    required this.repository,
  });

  final Repository repository;

  @override
  Future<String?> getActor() {
    return repository.user;
  }

  @override
  Future<String?> getRepository() {
    return repository.name;
  }

  @override
  String get vendor => 'Local';
}
