import 'dart:io';

import 'package:process/process.dart';
import 'package:test/test.dart';

import '../../bin/git/top_level.dart';

void main() {
  test('bad git command', () async {
    await expectLater(
      runGit(
        ['not-a-command'],
        processManager: const LocalProcessManager(),
      ),
      throwsA(
        isA<ProcessException>()
            .having(
              (pe) => pe.message,
              'message',
              contains("'not-a-command' is not a git command."),
            )
            .having((pe) => pe.errorCode, 'errorCode', 1),
      ),
    );
  });
}
