import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:process/process.dart';
import 'package:test/test.dart';

import '../../bin/git/diff_header.dart';
import '../../bin/git/reference.dart';
import '../../bin/git/repository.dart';
import '../utils/mocks.dart';

void main() {
  late ProcessManager processManager;
  late dynamic Function() processRun;
  late Repository repository;

  setUp(() {
    processManager = MockProcessManager();
    processRun = () => processManager.run(
          any(),
          workingDirectory: any(named: 'workingDirectory'),
          runInShell: any(named: 'runInShell'),
        );

    repository = Repository.raw(
      Directory.current.path,
      processManager,
    );
  });

  test(
    'diff returns []',
    () async {
      when(processRun).thenAnswer(
        ($) async => MockProcessResult.success(''),
      );

      expectLater(
        repository.diff(),
        completion(isEmpty),
      );
    },
  );

  test(
    'diff can parse add, change, delete',
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
        repository.diff(),
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

  test('currentBranch returns main', () {
    when(
      () => processManager.run(
        any(that: contains('rev-parse')),
        workingDirectory: any(named: 'workingDirectory'),
        runInShell: any(named: 'runInShell'),
      ),
    ).thenAnswer(
      ($) async => MockProcessResult.success('refs/heads/main'),
    );

    when(
      () => processManager.run(
        any(that: contains('show-ref')),
        workingDirectory: any(named: 'workingDirectory'),
        runInShell: any(named: 'runInShell'),
      ),
    ).thenAnswer(
      ($) async => MockProcessResult.success(
        '832e76a9899f560a90ffd62ae2ce83bbeff58f54 refs/heads/main',
      ),
    );

    expectLater(
      repository.currentBranch,
      completion(
        const Reference(
          '832e76a9899f560a90ffd62ae2ce83bbeff58f54',
          'refs/heads/main',
        ),
      ),
    );
  });

  test('branches returns refs', () async {
    when(processRun).thenAnswer(
      ($) async => MockProcessResult.success(
        '''
        832e76a9899f560a90ffd62ae2ce83bbeff58f54 HEAD
        832e76a9899f560a90ffd62ae2ce83bbeff58f54 refs/heads/main
        832e76a9899f560a90ffd62ae2ce83bbeff58f54 refs/remotes/origin/main
        3521017556c5de4159da4615a39fa4d5d2c279b5 refs/tags/v0.99.9c
        ''',
      ),
    );

    expectLater(
      repository.branches,
      completion(const [
        Reference(
          '832e76a9899f560a90ffd62ae2ce83bbeff58f54',
          'refs/heads/main',
        ),
        Reference(
          '832e76a9899f560a90ffd62ae2ce83bbeff58f54',
          'refs/remotes/origin/main',
        ),
      ]),
    );
  });

  group('findBranch', () {
    test('local branch', () {
      when(processRun).thenAnswer(
        ($) async => MockProcessResult.success(
          '''
          832e76a9899f560a90ffd62ae2ce83bbeff58f54 HEAD
          832e76a9899f560a90ffd62ae2ce83bbeff58f54 refs/heads/main
          3521017556c5de4159da4615a39fa4d5d2c279b5 refs/heads/feat/foo
          ''',
        ),
      );

      expectLater(
        repository.findBranch('main'),
        completion(
          const Reference(
            '832e76a9899f560a90ffd62ae2ce83bbeff58f54',
            'refs/heads/main',
          ),
        ),
      );
    });

    test('remote branch', () {
      when(processRun).thenAnswer(
        ($) async => MockProcessResult.success(
          '''
          832e76a9899f560a90ffd62ae2ce83bbeff58f54 HEAD
          832e76a9899f560a90ffd62ae2ce83bbeff58f54 refs/remotes/origin/main
          3521017556c5de4159da4615a39fa4d5d2c279b5 refs/heads/feat/foo
          ''',
        ),
      );

      expectLater(
        repository.findBranch(
          'main',
          remote: true,
        ),
        completion(
          const Reference(
            '832e76a9899f560a90ffd62ae2ce83bbeff58f54',
            'refs/remotes/origin/main',
          ),
        ),
      );
    });

    test('fetch is called if remote is true', () {
      when(processRun).thenAnswer(
        ($) async => MockProcessResult.success(''),
      );

      repository.findBranch('main', remote: true);

      verify(
        () => processManager.run(
          ['git', 'fetch'],
          workingDirectory: any(named: 'workingDirectory'),
          runInShell: any(named: 'runInShell'),
        ),
      ).called(1);
    });
  });
}
