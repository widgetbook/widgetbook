import '../git/git_dir.dart';
import 'ci_parser.dart';

class LocalParser extends CiParser {
  LocalParser({
    required super.argResults,
    required this.gitDir,
  });

  final GitDir gitDir;

  @override
  Future<String?> getActor() {
    return gitDir.user;
  }

  @override
  Future<String?> getRepository() {
    return gitDir.name;
  }

  @override
  String get vendor => 'Local';
}
