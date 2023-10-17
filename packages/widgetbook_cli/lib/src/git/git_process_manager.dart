import 'dart:async';
import 'dart:io';

import 'package:process/process.dart';

/// Similar to [run] but for `git`.
extension GitProcessManager on ProcessManager {
  static const executable = 'git';

  /// Runs `git` with the given [args] inside the [workingDirectory].
  /// If [workingDirectory] is `null` the current working directory is used.
  /// Throws a [ProcessException] if the exit code is not `0`.
  Future<String> runGit(
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
