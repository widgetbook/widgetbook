import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:process/process.dart';

import 'diff_header.dart';
import 'git_process_manager.dart';
import 'reference.dart';

class GitDir {
  GitDir.raw(
    this.path,
    this.processManager,
  ) : assert(p.isAbsolute(path));

  final String path;
  final ProcessManager processManager;

  /// Runs a git command in the current working directory
  /// using the local [processManager].
  Future<String> runLocal(List<String> args) {
    return processManager.runGit(
      args,
      workingDirectory: path,
    );
  }

  Future<String> getActorName() async {
    return runLocal(['config', 'user.name']);
  }

  Future<String> getRepositoryName() async {
    final topLevel = await runLocal(['rev-parse', '--show-toplevel']);
    return topLevel.split('/').last;
  }

  Future<List<Reference>> allBranches() async {
    try {
      const splitter = LineSplitter();
      final output = await runLocal(['show-ref']);
      final lines = splitter.convert(output.trim());

      return lines //
          .map(Reference.parse)
          .where((ref) => ref.isBranch)
          .toList();
    } catch (e) {
      return [];
    }
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

  Future<Reference> currentBranch() async {
    final refFullName = await runLocal(
      ['rev-parse', '--verify', '--symbolic-full-name', 'HEAD'],
    );

    final refLine = await runLocal(
      ['show-ref', '--verify', refFullName],
    );

    return Reference.parse(refLine);
  }

  Future<List<DiffHeader>> diff([String? base]) async {
    final args = ['diff', if (base != null) base];
    final output = await runLocal(args);

    final diffs = output
        .split('diff --git ')
        .where((x) => x.isNotEmpty); // First element is always empty

    return diffs.map(DiffHeader.parse).toList();
  }

  Future<bool> isWorkingTreeClean() async {
    final status = await runLocal(['status', '--porcelain']);
    return status.isEmpty;
  }

  static Future<bool> isGitDir(
    String path, [
    ProcessManager processManager = const LocalProcessManager(),
  ]) async {
    try {
      final dir = Directory(path);

      if (!dir.existsSync()) return false;

      // using rev-parse because it will fail in many scenarios
      // including if the directory provided is a bare repository
      await processManager.runGit(
        ['rev-parse'],
        workingDirectory: dir.path,
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  /// If [allowSubdirectory] is true, a [GitDir] may be returned if [gitDirRoot]
  /// is a subdirectory within a Git repository.
  static Future<GitDir> fromExisting(
    String gitDirRoot, {
    bool allowSubdirectory = false,
    ProcessManager processManager = const LocalProcessManager(),
  }) async {
    final path = p.absolute(gitDirRoot);

    final gitDir = await processManager.runGit(
      ['rev-parse', '--git-dir'],
      workingDirectory: path,
    );

    if (gitDir == '.git') {
      return GitDir.raw(path, processManager);
    }

    if (allowSubdirectory && p.basename(gitDir) == '.git') {
      final parentDir = p.dirname(gitDir);

      if (p.isWithin(parentDir, path)) {
        return GitDir.raw(parentDir, processManager);
      }
    }

    throw ArgumentError('The provided value "$gitDirRoot" is not '
        'the root of a git directory');
  }
}
