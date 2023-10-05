import 'package:mocktail/mocktail.dart';
import 'package:process/process.dart';
import 'package:test/test.dart';
import 'package:test_descriptor/test_descriptor.dart' as d;

import '../../bin/git/diff_header.dart';
import '../../bin/git/reference.dart';
import '../../bin/git/repository.dart';
import '../mocks/command_mocks.dart';

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
      d.sandbox,
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

  test('currentBranch', () {
    const sha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';
    const fullName = 'refs/heads/main';

    when(
      () => processManager.run(
        any(that: containsAll(['rev-parse', 'HEAD'])),
        workingDirectory: any(named: 'workingDirectory'),
        runInShell: any(named: 'runInShell'),
      ),
    ).thenAnswer(
      ($) async => MockProcessResult.success(fullName),
    );

    when(
      () => processManager.run(
        any(that: containsAll(['show-ref', fullName])),
        workingDirectory: any(named: 'workingDirectory'),
        runInShell: any(named: 'runInShell'),
      ),
    ).thenAnswer(
      ($) async => MockProcessResult.success(
        '$sha $fullName',
      ),
    );

    expectLater(
      repository.currentBranch,
      completion(
        Reference(sha, fullName),
      ),
    );
  });

  test('findRef', () {
    const sha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';
    const branch = 'main';
    const fullName = 'refs/heads/$branch';

    when(
      () => processManager.run(
        any(that: containsAll(['show-ref', branch])),
        workingDirectory: any(named: 'workingDirectory'),
        runInShell: any(named: 'runInShell'),
      ),
    ).thenAnswer(
      ($) async => MockProcessResult.success(
        '$sha $fullName',
      ),
    );

    expectLater(
      repository.findRef(branch),
      completion(
        Reference(sha, fullName),
      ),
    );
  });
}
