import 'git_dir.dart';

/// Manages the creation of [GitDir]s, to easily mock the result.
class GitManager {
  const GitManager();

  GitDir load(String dir) {
    return GitDir.load(dir);
  }
}
