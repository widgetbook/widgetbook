import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
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

  Future<List<Reference>> get branches async {
    try {
      const splitter = LineSplitter();
      final output = await runLocal(['show-ref']);
      final lines = splitter.convert(output);

      return lines //
          .map(Reference.parse)
          .where((ref) => ref.isBranch)
          .toList();
    } catch (e) {
      return [];
    }
  }

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

  Future<List<DiffHeader>> diff([String? base]) async {
    final args = ['diff', if (base != null) base];
    final output = await runLocal(args);

    final diffs = output
        .split('diff --git ')
        .where((x) => x.isNotEmpty); // First element is always empty

    return diffs.map(DiffHeader.parse).toList();
  }

  /// Finds a branch by its [name], returns `null` if not found.
  /// If [remote] is true, the remote branches will be retrieved first.
  ///
  /// Some CI Providers (e.g. GitHub Actions) do not have all branches by
  /// default because they do shallow checkout. For example, if you have a
  /// branch called `feature/branch` and you open a PR based on `main`,
  /// the CI will only have `feature/branch` but not `main`.
  /// In this case, you can set [remote] to true to fetch all branches,
  /// then searching for `main` will work because a branch named `origin/main`
  /// will be found.
  Future<Reference?> findBranch(
    String name, {
    bool remote = false,
  }) async {
    if (remote) await runLocal(['fetch']);

    final branches = await this.branches;

    return branches.firstWhereOrNull(
      (branch) {
        return branch.fullName == name ||
            branch.name == name ||
            branch.name == 'origin/$name';
      },
    );
  }
}
