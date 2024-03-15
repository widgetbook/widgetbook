import 'dart:async';

import 'package:path/path.dart' as path;
import 'package:process/process.dart';

import '../utils/executable_manager.dart';
import 'reference.dart';

/// Class representation of a git repository.
class Repository {
  Repository.raw(
    this.rootDir,
    this.processManager,
  ) : assert(path.isAbsolute(rootDir));

  final String rootDir;
  final ProcessManager processManager;

  /// Loads the [Repository] that contains the given [dir].
  /// Returns `null` if the [dir] is not in a git repository.
  static Future<Repository?> load(
    String dir, {
    ProcessManager processManager = const LocalProcessManager(),
  }) async {
    try {
      final absoluteDir = path.absolute(dir);
      final rootDir = await processManager.runGit(
        ['rev-parse', '--show-toplevel'],
        workingDirectory: absoluteDir,
      );

      return Repository.raw(rootDir, processManager);
    } catch (_) {
      return null;
    }
  }

  /// Gets the current name of the repository.
  String get name {
    return rootDir.split('/').last;
  }

  /// Gets the current git user's name.
  Future<String> get user async {
    return runLocal(['config', 'user.name']);
  }

  /// Returns `true` if the working directory is clean
  /// (i.e. no uncommitted changes).
  Future<bool> get isClean async {
    final status = await runLocal(['status', '--porcelain']);
    return status.isEmpty;
  }

  /// Gets a [Reference] for the current checked out branch.
  Future<Reference> get currentBranch async {
    final refFullName = await runLocal(
      ['rev-parse', '--verify', '--symbolic-full-name', 'HEAD'],
    );

    final refLine = await runLocal(
      ['show-ref', '--verify', refFullName],
    );

    return Reference.parse(refLine);
  }

  /// Runs a git command in the current working directory
  /// using the local [processManager].
  Future<String> runLocal(List<String> args) {
    return processManager.runGit(
      args,
      workingDirectory: rootDir,
    );
  }
}
