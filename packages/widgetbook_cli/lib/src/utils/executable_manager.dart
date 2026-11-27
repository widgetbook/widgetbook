import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:process/process.dart';

extension ExecutableManager on ProcessManager {
  /// Runs `flutter` with the given [args] inside the [workingDirectory].
  /// If [workingDirectory] is `null` the current working directory is used.
  Future<String> runFlutter(
    List<String> args, {
    String? workingDirectory,
  }) {
    return _exec(
      'flutter',
      args,
      workingDirectory: workingDirectory,
    );
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

  /// Starts [executable] with the given [args] inside the [workingDirectory]
  /// and returns its exit code once it exits.
  ///
  /// Its output is forwarded to [stdout] and [stderr] as it is written, and
  /// each line of it is passed to [onLine]. A `SIGINT` (Ctrl-C) is forwarded
  /// to it, so the CLI exits with its code instead of leaving it behind.
  /// As `flutter test` exits with `0` when interrupted, an interrupted run
  /// returns `130` instead, so it is never mistaken for a passing one.
  Future<int> stream(
    String executable,
    List<String> args, {
    String? workingDirectory,
    void Function(String line)? onLine,
  }) async {
    final process = await start(
      [executable, ...args],
      workingDirectory: workingDirectory,
      // Only needed for the `.bat` wrappers of `flutter` and `dart`; a shell
      // would not forward the signal to the child.
      runInShell: Platform.isWindows,
    );

    var interrupted = false;
    final sigint = ProcessSignal.sigint.watch().listen((signal) {
      interrupted = true;
      process.kill(signal);
    });

    Future<void> forward(Stream<List<int>> output, IOSink sink) {
      return output
          .map((bytes) {
            sink.add(bytes);
            return bytes;
          })
          .transform(const Utf8Decoder(allowMalformed: true))
          .transform(const LineSplitter())
          .forEach((line) => onLine?.call(line));
    }

    try {
      await Future.wait([
        forward(process.stdout, stdout),
        forward(process.stderr, stderr),
      ]);

      final exitCode = await process.exitCode;
      return interrupted && exitCode == 0 ? 130 : exitCode;
    } finally {
      await sigint.cancel();
    }
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
