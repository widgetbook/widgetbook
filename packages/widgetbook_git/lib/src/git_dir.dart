import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import 'bot.dart';
import 'branch_reference.dart';
import 'commit.dart';
import 'commit_reference.dart';
import 'diff_header.dart';
import 'file_diff.dart';
import 'git_error.dart';
import 'hunk.dart';
import 'tag.dart';
import 'top_level.dart';
import 'tree_entry.dart';
import 'util.dart';

class GitDir {
  static const _workTreeArg = '--work-tree=';
  static const _gitDirArg = '--git-dir=';
  static final RegExp _shaRegExp = RegExp(r'^[a-f0-9]{40}$');

  final String _path;
  final String? _gitWorkTree;

  GitDir._raw(this._path, [this._gitWorkTree])
      : assert(p.isAbsolute(_path)),
        assert(_gitWorkTree == null || p.isAbsolute(_gitWorkTree));

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

  /// [revision] should probably be a sha1 to a commit.
  /// But GIT lets you do other things.
  /// See http://git-scm.com/docs/gitrevisions.html
  Future<Commit> commitFromRevision(String revision) async {
    final pr = await runCommand(['cat-file', '-p', revision]);
    return Commit.parse(pr.stdout as String);
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

  // TODO: Test this! No tags. Many tags. Etc.
  Stream<Tag> tags() async* {
    final refs = await showRef(tags: true);

    for (var ref in refs) {
      final pr = await runCommand(['cat-file', '-p', ref.sha]);
      yield Tag.parseCatFile(pr.stdout as String);
    }
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
        const ['rev-parse', '--verify', '--symbolic-full-name', 'HEAD']);

    pr = await runCommand(
        ['show-ref', '--verify', (pr.stdout as String).trim()]);

    return CommitReference.fromShowRefOutput(pr.stdout as String)
        .single
        .toBranchReference();
  }

  Future<List<TreeEntry>> lsTree(String treeish,
      {bool subTreesOnly = false, String? path}) async {
    final args = ['ls-tree'];

    if (subTreesOnly == true) {
      args.add('-d');
    }

    args.add(treeish);

    if (path != null) {
      args.add(path);
    }

    final pr = await runCommand(args);
    return TreeEntry.fromLsTreeOutput(pr.stdout as String);
  }

  /// Returns the SHA for the new commit if one is created.
  ///
  /// `null` if the branch is not updated.
  Future<String?> createOrUpdateBranch(
      String branchName, String treeSha, String commitMessage) async {
    requireArgumentNotNullOrEmpty(branchName, 'branchName');
    requireArgumentValidSha1(treeSha, 'treeSha');

    final targetBranchRef = await branchReference(branchName);

    String? newCommitSha;

    if (targetBranchRef == null) {
      newCommitSha = await commitTree(treeSha, commitMessage);
    } else {
      newCommitSha =
          await _updateBranch(targetBranchRef.sha, treeSha, commitMessage);
    }

    if (newCommitSha == null) {
      return null;
    }

    assert(isValidSha(newCommitSha));

    final branchRef = 'refs/heads/$branchName';

    // TODO: if update-ref fails should we leave the new commit dangling?
    // or at least log so the user can go clean up?
    await runCommand(['update-ref', branchRef, newCommitSha]);
    return newCommitSha;
  }

  /// Returns the SHA for the new commit if one is created.
  ///
  /// `null` if the branch is not updated.
  Future<String?> _updateBranch(
      String targetBranchSha, String treeSha, String commitMessage) async {
    final commitObj = await commitFromRevision(targetBranchSha);
    if (commitObj.treeSha == treeSha) {
      return null;
    }

    return commitTree(treeSha, commitMessage,
        parentCommitShas: [targetBranchSha]);
  }

  /// Returns the `SHA1` for the new commit.
  ///
  /// See [git-commit-tree](http://git-scm.com/docs/git-commit-tree)
  Future<String> commitTree(
    String treeSha,
    String commitMessage, {
    List<String>? parentCommitShas,
  }) async {
    requireArgumentValidSha1(treeSha, 'treeSha');

    requireArgumentNotNullOrEmpty(commitMessage, 'commitMessage');
    requireArgument(commitMessage.trim() == commitMessage, 'commitMessage',
        'Value cannot start or end with whitespace.');

    parentCommitShas ??= [];

    final args = ['commit-tree', treeSha, '-m', commitMessage];

    for (final parentSha in parentCommitShas) {
      requireArgumentValidSha1(parentSha, 'parentCommitShas');
      args.addAll(['-p', parentSha]);
    }

    final pr = await runCommand(args);
    final sha = (pr.stdout as String).trim();
    assert(isValidSha(sha));
    return sha;
  }

  // TODO: should be renamed writeBlob?
  /// Given a list of [paths], write those files to the object store
  /// and return a [Map] where the key is the input path and the value is
  /// the SHA of the newly written object.
  Future<Map<String, String>> writeObjects(List<String> paths) async {
    final args = [
      'hash-object',
      '-t',
      'blob',
      '-w',
      '--no-filters',
      '--',
      ...paths
    ];

    final pr = await runCommand(args);
    final val = (pr.stdout as String).trim();
    final shas = val.split(RegExp(r'\s+'));
    assert(shas.length == paths.length);
    assert(shas.every(_shaRegExp.hasMatch));
    final map = <String, String>{};
    for (var i = 0; i < shas.length; i++) {
      map[paths[i]] = shas[i];
    }
    return map;
  }

  Future<Iterable<FileDiff>> diff({
    String? base,
    String? ref,
    List<String> paths = const <String>[],
  }) async {
    final args = ['diff'];

    if (base != null && ref != null) {
      args.add('$base...$ref');
    } else if (base != null) {
      args.add(base);
    } else if (ref != null) {
      args.add('...$ref');
    }

    args
      ..add('--')
      ..addAll(paths);

    final pr = await runCommand(args);
    // TODO no error handling here

    final diff = pr.stdout as String;

    DiffHeader _parseHeader(String fileDiff) {
      // Header might look like this:
      // diff --git a/builtin-http-fetch.c b/http-fetch.c
      // similarity index 95%
      // rename from builtin-http-fetch.c
      // rename to http-fetch.c
      // index f3e63d7..e8f44ba 100644
      // --- a/builtin-http-fetch.c
      // +++ b/http-fetch.c
      final baseFile = RegExp(r'(?<=--- a).*').stringMatch(fileDiff);
      final refFile = RegExp(r'(?<=\+\+\+ b).*').stringMatch(fileDiff);

      return DiffHeader(
        baseFile: baseFile,
        refFile: refFile,
      );
    }

    HunkRange _parseHunkRange(
      RegExpMatch match,
    ) {
      final startLineGroup = match.group(1);
      final numberOfLinesGroup = match.group(2);
      // Skip the sign, since otherwise the line number will be parsed to a
      // negative number for the base start line
      final startLineString = startLineGroup!.substring(1);

      late String numberOfLinesString;
      if (numberOfLinesGroup != null) {
        numberOfLinesString = numberOfLinesGroup.substring(1);
      } else {
        // This group will not exists if the number of lines are omitted
        // which happens when the number of lines is 1
        numberOfLinesString = 1.toString();
      }

      return HunkRange(
        startLine: int.parse(startLineString),
        numberOfLines: int.parse(numberOfLinesString),
      );
    }

    Hunk _parseHunk({
      required RegExpMatch baseHunkMatch,
      required RegExpMatch refHunkMatch,
      required int? nextHunkStart,
    }) {
      final baseHunk = _parseHunkRange(baseHunkMatch);
      final refHunk = _parseHunkRange(refHunkMatch);
      final content = baseHunkMatch.input
          .substring(
            baseHunkMatch.start,
            nextHunkStart,
          )
          .replaceAll(
            '\\ No newline at end of file\n',
            '',
          );
      return Hunk(
        baseRange: baseHunk,
        refRange: refHunk,
        content: content,
      );
    }

    Iterable<Hunk> _parseHunks(String fileDiff) sync* {
      // Hunk might look like this:
      // @@ -54,6 +54,10 @@ class HotReload extends StatelessWidget {
      //                        name: 'FAB',
      //                        builder: (context) => fabUseCase(context),
      //                      ),
      // +                    WidgetbookUseCase(
      // +                      name: 'FAB (text)',
      // +                      builder: (context) => fabTextUseCase(context),
      // +                    ),
      //                    ],
      //                  ),
      //                ],

      // TODO based on SO https://stackoverflow.com/questions/2529441/how-to-read-the-output-from-git-diff
      // There might be a case where the hunk does not contain any numbers for
      // ref or base or both

      final baseMatches = RegExp(
        r'@@ (-\d*)(,\d*)?',
      ).allMatches(fileDiff).toList();
      final refMatches = RegExp(
        r'(\+\d*)(,\d*)? @@',
      ).allMatches(fileDiff).toList();

      for (var counter = 0; counter < baseMatches.length; counter++) {
        final isLast = counter + 1 == baseMatches.length;
        yield _parseHunk(
          baseHunkMatch: baseMatches[counter],
          refHunkMatch: refMatches[counter],
          nextHunkStart: isLast ? null : baseMatches[counter].start,
        );
      }
    }

    FileDiff getFileDiff(String fileDiff) {
      final header = _parseHeader(fileDiff);
      final hunks = _parseHunks(fileDiff).toList();
      return FileDiff(
        basePath: header.baseFile,
        refPath: header.refFile,
        hunks: hunks,
      );
    }

    Iterable<FileDiff> getFiles(
      String totalDiff,
    ) {
      final diffs = totalDiff
          .split('diff --git ')
          // TODO somehow first element is always empty. Unclear
          .where((element) => element.isNotEmpty)
          .toList();
      final fileDiffs = <FileDiff>[];
      for (final diff in diffs) {
        fileDiffs.add(getFileDiff(diff));
      }
      return fileDiffs;
    }

    final files = getFiles(diff);
    return files;
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
          !arg.contains(_workTreeArg), 'args', 'Cannot contain $_workTreeArg');
      requireArgument(
          !arg.contains(_gitDirArg), 'args', 'Cannot contain $_gitDirArg');
    }

    if (_gitWorkTree != null) {
      list.insert(0, '$_workTreeArg$_gitWorkTree');
    }

    return runGit(list,
        throwOnError: throwOnError, processWorkingDir: _processWorkingDir);
  }

  Future<bool> isWorkingTreeClean() => runCommand(['status', '--porcelain'])
      .then((pr) => (pr.stdout as String).isEmpty);

  // TODO: TEST: someone puts a git dir when populated
  // TODO: TEST: someone puts in no content at all

  /// Updates the named branch with the content add by calling [populater].
  ///
  /// [populater] is called with a temporary [Directory] instance that should
  /// be populated with the desired content.
  ///
  /// If the content provided matches the content in the specificed
  /// [branchName], then no [Commit] is created and `null` is returned.
  ///
  /// If no content is added to the directory, an error is thrown.
  Future<Commit?> updateBranch(
    String branchName,
    Future Function(Directory td) populater,
    String commitMessage,
  ) async {
    // TODO: ponder restricting branch names
    // see http://stackoverflow.com/questions/12093748/how-do-i-check-for-valid-git-branch-names/12093994#12093994

    requireArgumentNotNullOrEmpty(branchName, 'branchName');
    requireArgumentNotNullOrEmpty(commitMessage, 'commitMessage');

    final tempContentRoot = await _createTempDir();

    try {
      await populater(tempContentRoot);
      final commit = await updateBranchWithDirectoryContents(
          branchName, tempContentRoot.path, commitMessage);
      return commit;
    } finally {
      await tempContentRoot.delete(recursive: true);
    }
  }

  Future<Commit?> updateBranchWithDirectoryContents(
    String branchName,
    String sourceDirectoryPath,
    String commitMessage,
  ) async {
    final tempGitRoot = await _createTempDir();

    final tempGitDir = GitDir._raw(tempGitRoot.path, sourceDirectoryPath);

    // time for crazy clone tricks
    final args = ['clone', '--shared', '--bare', path, '.'];

    await runGit(args, processWorkingDir: tempGitDir.path);

    await tempGitDir
        .runCommand(['symbolic-ref', 'HEAD', 'refs/heads/$branchName']);

    try {
      // make sure there is something in the working three
      var pr = await tempGitDir.runCommand(['ls-files', '--others']);

      if ((pr.stdout as String).isEmpty) {
        throw GitError('No files were added');
      }
      // add new files to index

      // --verbose is not strictly needed, but nice for debugging
      pr = await tempGitDir.runCommand(['add', '--all', '--verbose']);

      // now to see if we have any changes here
      pr = await tempGitDir.runCommand(['status', '--porcelain']);

      if ((pr.stdout as String).isEmpty) {
        // no change in files! we should return a null result
        return null;
      }

      // Time to commit.
      await tempGitDir.runCommand(['commit', '--verbose', '-m', commitMessage]);

      // --verbose is not strictly needed, but nice for debugging
      await tempGitDir
          .runCommand(['push', '--verbose', '--progress', path, branchName]);

      // pr.stderr will have all of the info

      // so we have this wonderful new commit, right?
      // need to crack out the commit and return the value
      return commitFromRevision('refs/heads/$branchName');
    } finally {
      await tempGitRoot.delete(recursive: true);
    }
  }

  String get _processWorkingDir => _path.toString();

  static Future<bool> isGitDir(String path) async {
    final dir = Directory(path);

    if (dir.existsSync()) {
      return _isGitDir(dir);
    } else {
      return false;
    }
  }

  /// [allowContent] if `true`, doesn't check to see if the directory is empty
  ///
  /// [initialBranch] if provided, specifies the initial branch name.
  /// If not provided, the default for git CLI is used.
  ///
  /// Will fail if the source is a git directory
  /// (either at the root or a sub directory).
  static Future<GitDir> init(
    String path, {
    bool allowContent = false,
    String? initialBranch,
  }) async {
    final source = Directory(path);
    assert(source.existsSync());

    if (allowContent == true) {
      return _init(source, branchName: initialBranch);
    }

    // else, verify it's empty
    final isEmpty = await source.list().isEmpty;
    if (!isEmpty) {
      throw ArgumentError('source Directory is not empty - $source');
    }
    return _init(source, branchName: initialBranch);
  }

  /// If [allowSubdirectory] is true, a [GitDir] may be returned if [gitDirRoot]
  /// is a subdirectory within a Git repository.
  static Future<GitDir> fromExisting(
    String gitDirRoot, {
    bool allowSubdirectory = false,
  }) async {
    final path = p.absolute(gitDirRoot);

    final pr = await runGit(['rev-parse', '--git-dir'],
        processWorkingDir: path.toString());

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

  static Future<GitDir> _init(Directory source, {String? branchName}) async {
    final isGitDir = await _isGitDir(source);
    if (isGitDir) {
      throw ArgumentError('Cannot init a directory that is already a '
          'git directory');
    }

    await runGit([
      'init',
      source.path,
      if (branchName != null) '--initial-branch=$branchName'
    ]);

    // does a bit more work than strictly necessary
    // but at least it ensures consistency
    return fromExisting(source.path);
  }

  static Future<bool> _isGitDir(Directory dir) async {
    assert(dir.existsSync());

    // using rev-parse because it will fail in many scenarios
    // including if the directory provided is a bare repository
    final pr = await runGit(['rev-parse'],
        throwOnError: false, processWorkingDir: dir.path);

    return pr.exitCode == 0;
  }
}

Future<Directory> _createTempDir() =>
    Directory.systemTemp.createTemp('git.GitDir.');
