import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import 'bot.dart';
import 'branch_reference.dart';
import 'commit.dart';
import 'commit_reference.dart';
import 'diff_header.dart';
import 'top_level.dart';

class GitDir {
  GitDir._raw(this._path, [this._gitWorkTree])
      : assert(p.isAbsolute(_path)),
        assert(_gitWorkTree == null || p.isAbsolute(_gitWorkTree));

  static const _workTreeArg = '--work-tree=';
  static const _gitDirArg = '--git-dir=';

  final String _path;
  final String? _gitWorkTree;

  String get path => _path;

  Future<int> commitCount([String branchName = 'HEAD']) async {
    final pr = await runCommand(['rev-list', '--count', branchName]);
    return int.parse(pr.stdout as String);
  }

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

  Future<Map<String, Commit>> commits([String branchName = 'HEAD']) async {
    final pr = await runCommand(['rev-list', '--format=raw', branchName]);
    return Commit.parseRawRevList(pr.stdout as String);
  }

  Future<BranchReference?> branchReference(String branchName) async {
    final list = await branches();
    final matches = list.where((b) => b.branchName == branchName).toList();

    assert(matches.length <= 1);
    if (matches.isEmpty) {
      return null;
    } else {
      return matches.single;
    }
  }

  Future<List<BranchReference>> branches() async {
    final refs = await showRef(heads: true);
    return refs.map((cr) => cr.toBranchReference()).toList();
  }

  Future<List<BranchReference>> allBranches() async {
    final refs = await showRef();
    return refs.map((cr) => cr.toBranchReference()).toList();
  }

  Future<void> fetch() async {
    await runCommand(['fetch'], throwOnError: false);
  }

  Future<List<String>> branch({
    bool all = false,
  }) async {
    final args = ['branch'];

    if (all) {
      args.add('-a');
    }

    final pr = await runCommand(args, throwOnError: false);
    if (pr.exitCode == 1) {
      // no heads present, return empty collection
      return [];
    }

    final branches = const LineSplitter()
        .convert(
          pr.stdout as String,
        )
        .map(
          (e) => e.substring(2).split(' ->').first,
        )
        .toList();

    return branches;
  }

  Future<List<CommitReference>> showRef({
    bool heads = false,
    bool tags = false,
  }) async {
    final args = ['show-ref'];

    if (heads) {
      args.add('--heads');
    }

    if (tags) {
      args.add('--tags');
    }

    final pr = await runCommand(args, throwOnError: false);
    if (pr.exitCode == 1) {
      // no heads present, return empty collection
      return [];
    }

    // otherwise, it should have worked fine...
    assert(pr.exitCode == 0);

    return CommitReference.fromShowRefOutput(pr.stdout as String);
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
        .split('diff --git ')
        .where((x) => x.isNotEmpty) // First element is always empty
        .toList();

    return diffs.map(DiffHeader.parse).toList();
  }

  Future<ProcessResult> runCommand(
    Iterable<String> args, {
    bool throwOnError = true,
  }) {
    ArgumentError.checkNotNull(args, 'args');

    final list = args.toList();

    for (final arg in list) {
      requireArgumentNotNullOrEmpty(arg, 'args');
      requireArgument(
        !arg.contains(_workTreeArg),
        'args',
        'Cannot contain $_workTreeArg',
      );
      requireArgument(
        !arg.contains(_gitDirArg),
        'args',
        'Cannot contain $_gitDirArg',
      );
    }

    if (_gitWorkTree != null) {
      list.insert(0, '$_workTreeArg$_gitWorkTree');
    }

    return runGit(
      list,
      throwOnError: throwOnError,
      processWorkingDir: _processWorkingDir,
    );
  }

  Future<bool> isWorkingTreeClean() => runCommand(['status', '--porcelain'])
      .then((pr) => (pr.stdout as String).isEmpty);

  String get _processWorkingDir => _path;

  static Future<bool> isGitDir(String path) async {
    final dir = Directory(path);

    if (dir.existsSync()) {
      return _isGitDir(dir);
    } else {
      return false;
    }
  }

  /// If [allowSubdirectory] is true, a [GitDir] may be returned if [gitDirRoot]
  /// is a subdirectory within a Git repository.
  static Future<GitDir> fromExisting(
    String gitDirRoot, {
    bool allowSubdirectory = false,
  }) async {
    final path = p.absolute(gitDirRoot);

    final pr = await runGit(
      ['rev-parse', '--git-dir'],
      processWorkingDir: path,
    );

    var returnedPath = (pr.stdout as String).trim();

    if (returnedPath == '.git') {
      return GitDir._raw(path);
    }

    if (allowSubdirectory && p.basename(returnedPath) == '.git') {
      returnedPath = p.dirname(returnedPath);

      if (p.isWithin(returnedPath, path)) {
        return GitDir._raw(returnedPath);
      }
    }

    throw ArgumentError('The provided value "$gitDirRoot" is not '
        'the root of a git directory');
  }

  static Future<bool> _isGitDir(Directory dir) async {
    assert(dir.existsSync());

    // using rev-parse because it will fail in many scenarios
    // including if the directory provided is a bare repository
    final pr = await runGit(
      ['rev-parse'],
      throwOnError: false,
      processWorkingDir: dir.path,
    );

    return pr.exitCode == 0;
  }
}
