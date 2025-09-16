import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:process/process.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';

void main() {
  late ProcessManager processManager;
  late Repository repository;

  setUp(() {
    processManager = MockProcessManager();
    repository = Repository.raw(
      Directory.current.path,
      processManager,
    );
  });

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
}
