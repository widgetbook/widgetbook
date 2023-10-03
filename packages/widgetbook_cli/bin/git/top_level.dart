import 'dart:async';
import 'dart:io';

import 'package:process/process.dart';

Future<ProcessResult> runGit(
  List<String> args, {
  String? workingDirectory,
  required ProcessManager processManager,
  bool throwOnError = true,
}) async {
  final result = await processManager.run(
    ['git', ...args],
    workingDirectory: workingDirectory,
    runInShell: true,
  );

  if (result.exitCode == 0 || !throwOnError) return result;

  final message = {
    'stdout': result.stdout.toString().trim(),
    'stderr': result.stderr.toString().trim(),
  }..removeWhere((k, v) => v.isEmpty);

  throw ProcessException(
    'git',
    args,
    message.toString(),
    result.exitCode,
  );
}
