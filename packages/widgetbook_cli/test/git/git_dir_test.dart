import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:test_descriptor/test_descriptor.dart' as d;

import '../../bin/git/commit.dart';
import '../../bin/git/diff_header.dart';
import '../../bin/git/git_dir.dart';

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

  test('getCommits', _testGetCommits);

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

  final indexMap = <int, MapEntry<String, Commit>>{};

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
    indexMap[commitMessageIndex] = MapEntry(commitSha, commit);
  });

  indexMap.forEach((index, shaCommitTuple) {
    if (index > 0) {
      expect(
        shaCommitTuple.value.parents,
        unorderedEquals([indexMap[index - 1]!.key]),
      );
    } else {
      expect(shaCommitTuple.value.parents, hasLength(0));
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

Future<GitDir> _createTempGitDir({String? branchName}) =>
    GitDir.fromExisting(d.sandbox);
