import 'dart:async';

import 'package:path/path.dart' as path;
import 'package:process/process.dart';

import '../helpers/helpers.dart';
import 'diff_header.dart';
import 'git_process_manager.dart';
import 'reference.dart';

class Repository {
  Repository.raw(
    this.rootDir,
    this.processManager,
  ) : assert(path.isAbsolute(rootDir));

  /// Loads the [Repository] that contains the given [dir].
  factory Repository.load(
    String dir, {
    ProcessManager processManager = const LocalProcessManager(),
  }) {
    try {
      final absoluteDir = path.absolute(dir);
      final dotGitDir = processManager.runGitSync(
        ['rev-parse', '--git-dir'],
        workingDirectory: absoluteDir,
      );

      final rootDir = path.dirname(dotGitDir);

      if (!path.isWithin(rootDir, absoluteDir)) {
        throw GitDirectoryNotFound();
      }

      return Repository.raw(rootDir, processManager);
    } catch (_) {
      throw GitDirectoryNotFound(
        message: 'The path "$dir" is not a valid git directory.',
      );
    }
  }

  final String rootDir;
  final ProcessManager processManager;

  Future<String> get user async {
    return runLocal(['config', 'user.name']);
  }

  Future<String> get name async {
    final topLevel = await runLocal(['rev-parse', '--show-toplevel']);
    return topLevel.split('/').last;
  }

  Future<bool> get isClean async {
    final status = await runLocal(['status', '--porcelain']);
    return status.isEmpty;
  }

  Future<Reference> get currentBranch async {
    final branchRef = await runLocal([
      'rev-parse',
      '--verify',
      '--symbolic-full-name',
      'HEAD',
    ]);

    final ref = await findRef(branchRef);

    return ref!;
  }

  /// Runs a git command in the current working directory
  /// using the local [processManager].
  Future<String> runLocal(List<String> args) {
    return processManager.runGit(
      args,
      workingDirectory: rootDir,
    );
  }

  /// Returns [true] if the fetch was successful, [false] otherwise.
  Future<bool> fetch() async {
    try {
      await runLocal(['fetch']);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<DiffHeader>> diff([String? base]) async {
    final args = ['diff', if (base != null) base];
    final output = await runLocal(args);

    final diffs = output
        .split('diff --git ')
        .where((x) => x.isNotEmpty); // First element is always empty

    return diffs.map(DiffHeader.parse).toList();
  }

  /// Returns a [Reference] for the given [ref] name.
  /// If the [ref] does not exist, [null] is returned.
  Future<Reference?> findRef(String ref) async {
    try {
      final output = await runLocal(
        ['show-ref', '--verify', ref],
      );

      return Reference.parse(output);
    } catch (_) {
      return null;
    }
  }
}
