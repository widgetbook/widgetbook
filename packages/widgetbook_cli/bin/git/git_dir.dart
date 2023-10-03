import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:process/process.dart';

import 'branch_reference.dart';
import 'commit_reference.dart';
import 'diff_header.dart';
import 'top_level.dart';

class GitDir {
  GitDir.raw(
    this.path,
    this.processManager,
  ) : assert(p.isAbsolute(path));

  final String path;
  final ProcessManager processManager;

  Future<String> getActorName() async {
    final results = await runCommand(['config', 'user.name']);
    final output = results.stdout as String;
    return output.trim();
  }

  Future<String> getRepositoryName() async {
    final results = await runCommand(['rev-parse', '--show-toplevel']);
    final output = results.stdout.toString().split('/').last;
    return output.trim();
  }

  Future<List<BranchReference>> allBranches() async {
    final pr = await runCommand(
      ['show-ref'],
      throwOnError: false,
    );

    if (pr.exitCode == 1) {
      // no heads present, return empty collection
      return [];
    }

    // otherwise, it should have worked fine...
    assert(pr.exitCode == 0);

    return CommitReference.fromShowRefOutput(pr.stdout as String)
        .map((e) => e.toBranchReference())
        .toList();
  }

  Future<void> fetch() async {
    await runCommand(['fetch'], throwOnError: false);
  }

  Future<BranchReference> currentBranch() async {
    var pr = await runCommand(
      const ['rev-parse', '--verify', '--symbolic-full-name', 'HEAD'],
    );

    pr = await runCommand(
      ['show-ref', '--verify', (pr.stdout as String).trim()],
    );

    return CommitReference.fromShowRefOutput(pr.stdout as String)
        .single
        .toBranchReference();
  }

  Future<List<DiffHeader>> diff([String? base]) async {
    final args = ['diff', if (base != null) base];
    final result = await runCommand(args);
    final output = result.stdout as String;

    final diffs = output
        .trim()
        .split('diff --git ')
        .where((x) => x.isNotEmpty) // First element is always empty
        .toList();

    return diffs.map(DiffHeader.parse).toList();
  }

  Future<ProcessResult> runCommand(
    List<String> args, {
    bool throwOnError = true,
  }) {
    return runGit(
      args,
      throwOnError: throwOnError,
      workingDirectory: path,
      processManager: processManager,
    );
  }

  Future<bool> isWorkingTreeClean() => runCommand(['status', '--porcelain'])
      .then((pr) => (pr.stdout as String).isEmpty);

  static Future<bool> isGitDir(
    String path, [
    ProcessManager processManager = const LocalProcessManager(),
  ]) async {
    final dir = Directory(path);

    if (!dir.existsSync()) return false;

    // using rev-parse because it will fail in many scenarios
    // including if the directory provided is a bare repository
    final result = await runGit(
      ['rev-parse'],
      throwOnError: false,
      workingDirectory: dir.path,
      processManager: processManager,
    );

    return result.exitCode == 0;
  }

  /// If [allowSubdirectory] is true, a [GitDir] may be returned if [gitDirRoot]
  /// is a subdirectory within a Git repository.
  static Future<GitDir> fromExisting(
    String gitDirRoot, {
    bool allowSubdirectory = false,
    ProcessManager processManager = const LocalProcessManager(),
  }) async {
    final path = p.absolute(gitDirRoot);

    final pr = await runGit(
      ['rev-parse', '--git-dir'],
      workingDirectory: path,
      processManager: processManager,
    );

    var returnedPath = (pr.stdout as String).trim();

    if (returnedPath == '.git') {
      return GitDir.raw(path, processManager);
    }

    if (allowSubdirectory && p.basename(returnedPath) == '.git') {
      returnedPath = p.dirname(returnedPath);

      if (p.isWithin(returnedPath, path)) {
        return GitDir.raw(returnedPath, processManager);
      }
    }

    throw ArgumentError('The provided value "$gitDirRoot" is not '
        'the root of a git directory');
  }
}
