import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart' as path;
import 'package:process/process.dart';

import '../helpers/helpers.dart';
import 'diff_header.dart';
import 'git_process_manager.dart';
import 'reference.dart';

class GitDir {
  GitDir.raw(
    this.rootDir,
    this.processManager,
  ) : assert(path.isAbsolute(rootDir));

  /// Loads the [GitDir] that contains the given [dir].
  factory GitDir.load(
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

      return GitDir.raw(rootDir, processManager);
    } catch (_) {
      throw GitDirectoryNotFound(
        message: 'The path "$dir" is not a valid git directory.',
      );
    }
  }

  final String rootDir;
  final ProcessManager processManager;

  /// Runs a git command in the current working directory
  /// using the local [processManager].
  Future<String> runLocal(List<String> args) {
    return processManager.runGit(
      args,
      workingDirectory: rootDir,
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
}
