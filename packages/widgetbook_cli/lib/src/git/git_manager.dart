import 'repository.dart';

/// Manages the creation of [Repository]s, to easily mock the result.
class GitManager {
  const GitManager();

  Repository load(String dir) {
    return Repository.load(dir);
  }
}
