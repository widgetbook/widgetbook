import 'dart:async';
import 'dart:io';

import 'package:process/process.dart';

extension GitProcessManager on ProcessManager {
  static const executable = 'git';

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

  String runGitSync(
    List<String> args, {
    String? workingDirectory,
  }) {
    final result = runSync(
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
