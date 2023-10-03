import 'dart:async';
import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as p;
import 'package:process/process.dart';
import 'package:test/test.dart';
import 'package:test_descriptor/test_descriptor.dart' as d;

import '../../bin/git/commit.dart';
import '../../bin/git/diff_header.dart';
import '../../bin/git/git_dir.dart';
import '../mocks/command_mocks.dart';

void main() {
  late ProcessManager processManager;
  late dynamic Function() processRun;
  late GitDir gitDir;

  setUp(() {
    processManager = MockProcessManager();
    processRun = () => processManager.run(
          any(),
          workingDirectory: any(named: 'workingDirectory'),
          runInShell: any(named: 'runInShell'),
        );

    gitDir = GitDir.raw(
      d.sandbox,
      processManager,
    );
  });

  group('diff', () {
    test(
      'returns []',
      () async {
        when(processRun).thenAnswer(
          ($) async => MockProcessResult.success(''),
        );

        expectLater(
          gitDir.diff(),
          completion(isEmpty),
        );
      },
    );

    test(
      'can parse add, change, delete',
      () async {
        when(processRun).thenAnswer(
          ($) async => MockProcessResult.success(
            '''
            diff --git a/file_add.txt b/file_add.txt
            new file mode 100644
            index 0000000..78169f5
            --- /dev/null
            +++ b/file_add.txt
            @@ -0,0 +1 @@
            +Widgetbook
            \ No newline at end of file
            diff --git a/file_change.txt b/file_change.txt
            index 515e7cc..6c17f58 100644
            --- a/file_change.txt
            +++ b/file_change.txt
            @@ -1 +1 @@
            -Storybook
            +Widgetbook
            diff --git a/file_delete.txt b/file_delete.txt
            deleted file mode 100644
            index 515e7cc..0000000
            --- a/file_delete.txt
            +++ /dev/null
            @@ -1 +0,0 @@
            -Storybook
            ''',
          ),
        );

        expectLater(
          gitDir.diff(),
          completion([
            DiffHeader(
              ref: '/file_add.txt',
            ),
            DiffHeader(
              ref: '/file_change.txt',
              base: '/file_change.txt',
            ),
            DiffHeader(
              base: '/file_delete.txt',
            ),
          ]),
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

      final gitDir = await _createTempGitDir();

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

Future<GitDir> _createTempGitDir() => GitDir.fromExisting(d.sandbox);
