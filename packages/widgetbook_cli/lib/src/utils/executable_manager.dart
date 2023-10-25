import 'dart:async';
import 'dart:io';

import 'package:process/process.dart';

extension ExecutableManager on ProcessManager {
  /// Runs `flutter` with the given [args].
  Future<String> runFlutter(List<String> args) {
    return _exec('flutter', args);
  }

  /// Runs `git` with the given [args] inside the [workingDirectory].
  /// If [workingDirectory] is `null` the current working directory is used.
  Future<String> runGit(
    List<String> args, {
    String? workingDirectory,
  }) {
    return _exec(
      'git',
      args,
      workingDirectory: workingDirectory,
    );
  }

  /// Executes [ProcessManager.run] on a given [executable].
  /// Throws a [ProcessException] if the exit code is not `0`.
  Future<String> _exec(
    String executable,
    List<String> args, {
    String? workingDirectory,
  }) async {
    final result = await run(
      [executable, ...args],
      workingDirectory: workingDirectory,
      runInShell: true,
    );

    if (result.exitCode == 0) return result.stdout.toString().trim();

    throw ProcessException(
      executable,
      args,
      result.stderr.toString().trim(),
      result.exitCode,
    );
  }
}
