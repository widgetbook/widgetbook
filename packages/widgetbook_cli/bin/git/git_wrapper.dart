import 'package:widgetbook_git/widgetbook_git.dart';

class GitWrapper {
  Future<bool> isGitDir(String path) {
    return GitDir.isGitDir(path);
  }

  Future<GitDir> fromExisting(
    String path, {
    bool allowSubdirectory = false,
  }) {
    return GitDir.fromExisting(
      path,
      allowSubdirectory: allowSubdirectory,
    );
  }
}
