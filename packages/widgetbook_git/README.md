[![Pub Package](https://img.shields.io/pub/v/git.svg)](https://pub.dev/packages/git)
[![CI](https://github.com/kevmoo/git/workflows/CI/badge.svg?branch=master)](https://github.com/kevmoo/git/actions?query=workflow%3ACI+branch%3Amaster)

A fork of the [git](https://pub.dev/packages/git) package which includes an API for the `git diff` command.

Exposes a Git directory abstraction that makes it easy to inspect and manipulate
a local Git repository.

```dart
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
```
