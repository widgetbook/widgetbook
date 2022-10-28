import 'package:widgetbook_git/widgetbook_git.dart';

import './ci_parser.dart';

class LocalParser extends CiParser {
  LocalParser({
    required super.argResults,
    required this.gitDir,
  });

  final GitDir gitDir;

  @override
  Future<String?> getActor() {
    return gitDir.getActorName();
  }

  @override
  Future<String?> getRepository() {
    return gitDir.getRepositoryName();
  }

  @override
  String get vendor => 'Local';
}
