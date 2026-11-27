import 'dart:io';

import 'package:path/path.dart' as p;

/// Whether a `build_runner` process, e.g. `build_runner watch`, is running on
/// the package at [packageDir] or on the workspace that contains it.
///
/// `build_runner` holds a file lock in `.dart_tool/build/lock` while it runs.
/// A second `build_runner build` would wait for it and ask it to exit, which
/// stops a running `watch`; this only tries the locks instead.
bool isBuildRunnerRunning(String packageDir) {
  var dir = p.normalize(p.absolute(packageDir));

  final packageLock = File(p.join(dir, _lockDir, 'build_runner.lock'));
  if (!_canLock(packageLock, FileLock.exclusive)) return true;

  // A workspace build holds an exclusive lock on the workspace root.
  while (true) {
    final workspaceLock = File(
      p.join(dir, _lockDir, 'build_runner.workspace.lock'),
    );
    if (!_canLock(workspaceLock, FileLock.shared)) return true;

    final parent = p.dirname(dir);
    if (parent == dir) return false;
    dir = parent;
  }
}

const _lockDir = '.dart_tool/build/lock';

/// Whether the [file] can be locked with [mode], or does not exist.
bool _canLock(File file, FileLock mode) {
  if (!file.existsSync()) return true;

  RandomAccessFile? lock;
  try {
    lock = file.openSync(mode: FileMode.append)..lockSync(mode);
    lock.unlockSync();
    return true;
  } on FileSystemException {
    return false;
  } finally {
    lock?.closeSync();
  }
}
