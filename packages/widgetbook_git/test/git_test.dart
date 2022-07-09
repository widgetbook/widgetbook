import 'dart:io';

import 'package:test/test.dart';
import 'package:widgetbook_git/widgetbook_git.dart';

void main() {
  test('bad git command', () async {
    await expectLater(
      runGit(['not-a-command']),
      throwsA(
        isA<ProcessException>()
            .having((pe) => pe.message, 'message',
                contains("'not-a-command' is not a git command."))
            .having((pe) => pe.errorCode, 'errorCode', 1),
      ),
    );
  });
}
