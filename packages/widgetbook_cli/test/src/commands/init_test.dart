@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/commands/init.dart';

import '../../helper/mocks.dart';

void main() {
  group('widgetbook init', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('wb_init_test');
      File(
        p.join(tempDir.path, 'pubspec.yaml'),
      ).writeAsStringSync('name: demo\n');
    });

    tearDown(() => tempDir.deleteSync(recursive: true));

    InitCommand buildCommand() => InitCommand(context: MockContext());

    test('parses --empty flag', () async {
      final command = buildCommand();
      final results = command.argParser.parse([
        '--package',
        tempDir.path,
        '--empty',
      ]);

      final args = await command.parseResults(MockContext(), results);

      expect(args.empty, isTrue);
      expect(args.packageDir, tempDir.path);
    });

    test('defaults --empty to false', () async {
      final command = buildCommand();
      final results = command.argParser.parse([
        '--package',
        tempDir.path,
      ]);

      final args = await command.parseResults(MockContext(), results);

      expect(args.empty, isFalse);
    });
  });
}
