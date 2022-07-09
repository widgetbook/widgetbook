import 'package:path/path.dart' as p;
import 'package:widgetbook_git/widgetbook_git.dart';

Future<void> main() async {
  print('Current directory: ${p.current}');

  if (await GitDir.isGitDir(p.current)) {
    final gitDir = await GitDir.fromExisting(p.current);
    final commitCount = await gitDir.commitCount();
    print('Git commit count: $commitCount');
  } else {
    print('Not a Git directory');
  }
}
