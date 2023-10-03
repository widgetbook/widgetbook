import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:test_descriptor/test_descriptor.dart' as d;

import '../../bin/git/bot.dart';
import '../../bin/git/commit.dart';
import '../../bin/git/diff_header.dart';
import '../../bin/git/git_dir.dart';
import '../../bin/git/git_error.dart';

void main() {
  group('diff', () {
    test(
      'returns []',
      () async {
        final gitDir = await _createTempGitDir();
        final diffs = await gitDir.diff();
        expect(diffs, isEmpty);
      },
    );

    test(
      'on new file returns [@@ -0,0 +1 @@]',
      () async {
        const initialMasterBranchContent = {
          'master.md': 'test file',
        };

        final gitDir = await _createTempGitDir();

        await _doDescriptorGitCommit(
          gitDir,
          initialMasterBranchContent,
          'master files',
        );

        await _doDescriptorGitCommit(
          gitDir,
          {
            'test.txt': 'test',
          },
          'test',
        );

        final commits = await gitDir.commits();

        final diffs = await gitDir.diff(
          commits.keys.last,
        );

        expect(
          diffs,
          equals(
            [
              DiffHeader(
                ref: '/test.txt',
              ),
            ],
          ),
        );
      },
    );

    test(
      'on deleted file returns [@@ -1 +0,0 @@]',
      () async {
        const initialMasterBranchContent = {
          'test.txt': 'test',
        };

        final gitDir = await _createTempGitDir();

        await _doDescriptorGitCommit(
          gitDir,
          initialMasterBranchContent,
          'master files',
        );

        await _doDescriptorGitRemove(
          gitDir,
          ['test.txt'],
          'test',
        );

        final commits = await gitDir.commits();

        final diffs = await gitDir.diff(
          commits.keys.last,
        );

        expect(
          diffs,
          equals(
            [
              DiffHeader(
                base: '/test.txt',
              ),
            ],
          ),
        );
      },
    );

    test(
      'on line change returns [@@ -1 +1 @@]',
      () async {
        const initialMasterBranchContent = {
          'test.md': 'line 1',
        };

        final gitDir = await _createTempGitDir();

        await _doDescriptorGitCommit(
          gitDir,
          initialMasterBranchContent,
          'not important',
        );

        const updatedMasterBranchContent = {
          'test.md': 'line 2',
        };

        await _doDescriptorGitCommit(
          gitDir,
          updatedMasterBranchContent,
          'not important',
        );

        final commits = await gitDir.commits();

        final diffs = await gitDir.diff(
          commits.keys.last,
        );

        expect(
          diffs,
          equals(
            [
              DiffHeader(
                ref: '/test.md',
                base: '/test.md',
              ),
            ],
          ),
        );
      },
    );
  });

  test('populateBranch', _testPopulateBranch);

  test('getCommits', _testGetCommits);

  test('writeObjects', () async {
    final gitDir = await _createTempGitDir();

    final branches = await gitDir.branches();
    expect(branches, isEmpty, reason: 'Should start with zero commits');

    final initialContentMap = {
      'file1.txt': 'content1',
      'file2.txt': 'content2',
    };

    await _doDescriptorPopulate(d.sandbox, initialContentMap);

    final paths = initialContentMap.keys
        .map((fileName) => p.join(d.sandbox, fileName))
        .toList();

    final hashes = await gitDir.writeObjects(paths);
    expect(hashes, hasLength(initialContentMap.length));
    expect(hashes.keys, unorderedEquals(paths));

    expect(paths[0], endsWith('file1.txt'));
    expect(
      hashes,
      containsPair(paths[0], 'dd954e7a4e1a62ff90c5a0709dce5928716535c1'),
    );

    expect(paths[1], endsWith('file2.txt'));
    expect(
      hashes,
      containsPair(paths[1], 'db00fd65b218578127ea51f3dffac701f12f486a'),
    );
  });

  group('BranchReference', () {
    test('isHead', () async {
      const initialMasterBranchContent = {
        'master.md': 'test file',
        'lib/foo.txt': 'lib foo text',
        'lib/bar.txt': 'lib bar text',
      };

      final gitDir = await _createTempGitDir(branchName: 'master');

      await _doDescriptorGitCommit(
        gitDir,
        initialMasterBranchContent,
        'master files',
      );

      final branch = await gitDir.currentBranch();
      expect(branch.isHead, isFalse);
      expect(branch.branchName, 'master');
      expect(branch.reference, 'refs/heads/master');

      await gitDir.runCommand(
        ['checkout', '--detach'],
      );

      final detached = await gitDir.currentBranch();
      expect(detached.isHead, isTrue);
      expect(detached.branchName, 'HEAD');
      expect(detached.reference, 'HEAD');
      expect(detached.sha, branch.sha);
    });
  });
}

Future<void> _testGetCommits() async {
  const commitText = [
    '',
    ' \t leading white space is okay, too',
    'first',
    'second',
    'third',
    'forth',
  ];

  String msgFromText(String txt) {
    if (txt.isNotEmpty && txt.trim() == txt) {
      return 'Commit for $txt\n\nnice\n\nhuh?';
    } else {
      return txt;
    }
  }

  final gitDir = await _createTempGitDir();

  final branches = await gitDir.branches();
  expect(branches, isEmpty);

  for (var commitStr in commitText) {
    final fileMap = <String, String>{};
    fileMap['$commitStr.txt'] = '$commitStr content';

    await _doDescriptorGitCommit(gitDir, fileMap, msgFromText(commitStr));
  }

  final count = await gitDir.commitCount();
  expect(count, commitText.length);

  final commits = await gitDir.commits();

  expect(commits, hasLength(commitText.length));

  final commitMessages = commitText.map(msgFromText).toList();

  final indexMap = <int, Tuple<String, Commit>>{};

  commits.forEach((commitSha, commit) {
    // index into the text for the message of this commit
    late int commitMessageIndex;
    for (var i = 0; i < commitMessages.length; i++) {
      if (commitMessages[i] == commit.message) {
        commitMessageIndex = i;
        break;
      }
    }

    expect(
      commitMessageIndex,
      isNotNull,
      reason: 'a matching message should be found',
    );

    expect(indexMap, isNot(contains(commitMessageIndex)));
    indexMap[commitMessageIndex] = Tuple(commitSha, commit);
  });

  indexMap.forEach((index, shaCommitTuple) {
    if (index > 0) {
      expect(
        shaCommitTuple.item2.parents,
        unorderedEquals([indexMap[index - 1]!.item1]),
      );
    } else {
      expect(shaCommitTuple.item2.parents, hasLength(0));
    }
  });
}

Future<ProcessResult> _doDescriptorGitRemove(
  GitDir gd,
  List<String> filePaths,
  String commitMsg,
) async {
  await _doDescriptorDepopulate(gd.path, filePaths);

  // now add the deleted file
  await gd.runCommand(['add', '--all']);

  // now commit these silly files
  final args = [
    'commit',
    '--cleanup=verbatim',
    '--no-edit',
    '--allow-empty-message',
  ];
  if (commitMsg.isNotEmpty) {
    args.addAll(['-m', commitMsg]);
  }

  return gd.runCommand(args);
}

Future<ProcessResult> _doDescriptorGitCommit(
  GitDir gd,
  Map<String, String> contents,
  String commitMsg,
) async {
  await _doDescriptorPopulate(gd.path, contents);

  // now add this new file
  await gd.runCommand(['add', '--all']);

  // now commit these silly files
  final args = [
    'commit',
    '--cleanup=verbatim',
    '--no-edit',
    '--allow-empty-message',
  ];
  if (commitMsg.isNotEmpty) {
    args.addAll(['-m', commitMsg]);
  }

  return gd.runCommand(args);
}

Future<void> _doDescriptorDepopulate(
  String dirPath,
  List<String> filePaths,
) async {
  for (final filePath in filePaths) {
    final fullPath = p.join(dirPath, filePath);
    final file = File(fullPath);
    await file.delete(recursive: true);
  }
}

Future<void> _doDescriptorPopulate(
  String dirPath,
  Map<String, String> contents,
) async {
  for (var name in contents.keys) {
    final value = contents[name]!;

    final fullPath = p.join(dirPath, name);

    final file = File(fullPath);
    await file.create(recursive: true);
    await file.writeAsString(value);
  }
}

Future<void> _testPopulateBranch() async {
  const initialMasterBranchContent = {'master.md': 'test file'};

  const testContent1 = {
    'file1.txt': 'file 1 contents',
    'file2.txt': 'file 2 contents',
    'file3.txt': 'not around very long',
  };

  const testContent2 = {
    'file1.txt': 'file 1 contents',
    'file2.txt': 'file 2 contents changed',
    'file4.txt': 'sorry, file3',
  };

  const testBranchName = 'the_test_branch';

  final gd1 = await _createTempGitDir();

  await _doDescriptorGitCommit(gd1, initialMasterBranchContent, 'master files');

  _testPopulateBranchEmpty(gd1, testBranchName);

  await _testPopulateBranchWithContent(
    gd1,
    testBranchName,
    testContent1,
    'first commit!',
  );

  await _testPopulateBranchWithContent(
    gd1,
    testBranchName,
    testContent2,
    'second commit',
  );

  await _testPopulateBranchWithDupeContent(
    gd1,
    testBranchName,
    testContent2,
    'same content',
  );

  await _testPopulateBranchWithContent(
    gd1,
    testBranchName,
    testContent1,
    '3rd commit, content 1',
  );

  _testPopulateBranchEmpty(gd1, testBranchName);
}

void _testPopulateBranchEmpty(GitDir gitDir, String branchName) {
  expect(
    _testPopulateBranchCore(gitDir, branchName, {}, 'empty?'),
    throwsA(
      isA<GitError>()
          .having((ge) => ge.message, 'message', 'No files were added'),
    ),
  );
}

Future<Tuple<Commit?, int>> _testPopulateBranchCore(
  GitDir gitDir,
  String branchName,
  Map<String, String> contents,
  String commitMessage,
) async {
  // figure out how many commits exist for the provided branch
  final branchRef = await gitDir.branchReference(branchName);

  int originalCommitCount;
  if (branchRef == null) {
    originalCommitCount = 0;
  } else {
    originalCommitCount = await gitDir.commitCount(branchRef.reference);
  }

  Directory? tempDir;
  try {
    final commit = await gitDir.updateBranch(
      branchName,
      (td) {
        // strictly speaking, users of this API should not hold on to TempDir
        // but this is for testing
        tempDir = td;

        return _doDescriptorPopulate(tempDir!.path, contents);
      },
      commitMessage,
    );

    return Tuple(commit, originalCommitCount);
  } finally {
    if (tempDir != null) {
      expect(tempDir!.existsSync(), false);
    }
  }
}

Future<void> _testPopulateBranchWithContent(
  GitDir gitDir,
  String branchName,
  Map<String, String> contents,
  String commitMessage,
) async {
  // figure out how many commits exist for the provided branch
  final pair = await _testPopulateBranchCore(
    gitDir,
    branchName,
    contents,
    commitMessage,
  );

  final returnedCommit = pair.item1!;
  final originalCommitCount = pair.item2;

  if (originalCommitCount == 0) {
    expect(
      returnedCommit.parents,
      isEmpty,
      reason: 'This should be the first commit',
    );
  } else {
    expect(returnedCommit.parents, hasLength(1));
  }

  expect(returnedCommit, isNotNull, reason: 'Commit should not be null');
  expect(returnedCommit.message, commitMessage);

  // new check to see if things are updated it gd1
  final branchRef = (await gitDir.branchReference(branchName))!;

  final commit = await gitDir.commitFromRevision(branchRef.reference);

  expect(
    commit.content,
    returnedCommit.content,
    reason: 'content of queried commit should what was returned',
  );

  // TODO:
  // final entries = await gitDir.lsTree(commit.treeSha);
  // expect(entries.map((te) => te.name), unorderedEquals(contents.keys));

  final newCommitCount = await gitDir.commitCount(branchRef.reference);
  expect(newCommitCount, originalCommitCount + 1);
}

Future<void> _testPopulateBranchWithDupeContent(
  GitDir gitDir,
  String branchName,
  Map<String, String> contents,
  String commitMessage,
) async {
  // figure out how many commits exist for the provided branch
  final pair = await _testPopulateBranchCore(
    gitDir,
    branchName,
    contents,
    commitMessage,
  );

  final returnedCommit = pair.item1;
  final originalCommitCount = pair.item2;

  expect(returnedCommit, isNull);
  expect(
    originalCommitCount,
    greaterThan(0),
    reason: 'must have had some original content',
  );

  // new check to see if things are updated it gd1
  final br = (await gitDir.branchReference(branchName))!;

  final newCommitCount = await gitDir.commitCount(br.reference);

  expect(
    newCommitCount,
    originalCommitCount,
    reason: 'no change in commit count',
  );
}

Future<GitDir> _createTempGitDir({String? branchName}) =>
    GitDir.fromExisting(d.sandbox);
