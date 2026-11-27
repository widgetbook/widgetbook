@TestOn('vm')
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/test/build_runner_lock.dart';

void main() {
  group('isBuildRunnerRunning', () {
    late Directory root;
    late String packageDir;

    setUp(() {
      root = Directory.systemTemp.createTempSync('wb_build_runner_lock');
      packageDir = p.join(root.path, 'packages', 'app');
      Directory(packageDir).createSync(recursive: true);
    });

    tearDown(() => root.deleteSync(recursive: true));

    /// Locks [lockFile] with [mode] from another process, as file locks
    /// never conflict within the process that holds them.
    Future<Process> lockFromAnotherProcess(String lockFile, String mode) async {
      final script = File(p.join(root.path, 'lock.dart'))
        ..writeAsStringSync('''
import 'dart:io';

void main() {
  final file = File(r'$lockFile')..createSync(recursive: true);
  file.openSync(mode: FileMode.append).lockSync(FileLock.$mode);
  print('locked');
  stdin.listen((_) {});
}
''');

      final process = await Process.start(
        Platform.resolvedExecutable,
        [script.path],
      );
      addTearDown(process.kill);

      await process.stdout
          .transform(utf8.decoder)
          .firstWhere((output) => output.contains('locked'));

      return process;
    }

    String lockFile(String dir, String name) {
      return p.join(dir, '.dart_tool', 'build', 'lock', name);
    }

    test('is false without lock files', () {
      expect(isBuildRunnerRunning(packageDir), isFalse);
    });

    test('is false when the lock files are not locked', () {
      File(lockFile(packageDir, 'build_runner.lock'))
        ..createSync(recursive: true)
        ..writeAsStringSync('');

      expect(isBuildRunnerRunning(packageDir), isFalse);
    });

    test('is true while a package build holds its lock', () async {
      await lockFromAnotherProcess(
        lockFile(packageDir, 'build_runner.lock'),
        'exclusive',
      );

      expect(isBuildRunnerRunning(packageDir), isTrue);
    });

    test('is true while a workspace build holds the workspace lock', () async {
      await lockFromAnotherProcess(
        lockFile(root.path, 'build_runner.workspace.lock'),
        'exclusive',
      );

      expect(isBuildRunnerRunning(packageDir), isTrue);
    });

    test('is false while another package of the workspace builds', () async {
      await lockFromAnotherProcess(
        lockFile(root.path, 'build_runner.workspace.lock'),
        'shared',
      );

      expect(isBuildRunnerRunning(packageDir), isFalse);
    });

    test('does not request the lock from the running build', () async {
      final lock = lockFile(packageDir, 'build_runner.lock');
      await lockFromAnotherProcess(lock, 'exclusive');

      isBuildRunnerRunning(packageDir);

      expect(File('$lock.requested').existsSync(), isFalse);
    });
  });
}
