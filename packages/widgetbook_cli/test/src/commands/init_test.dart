@TestOn('vm')
library;

import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/commands/init.dart';
import 'package:widgetbook_cli/src/commands/init_args.dart';

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

    test('adds material_ui and uses it in the generated config', () async {
      final processManager = MockProcessManager();
      when(
        () => processManager.run(
          any(),
          workingDirectory: any(named: 'workingDirectory'),
          runInShell: any(named: 'runInShell'),
        ),
      ).thenAnswer((_) async => MockProcessResult.success(''));

      final command = InitCommand(
        context: MockContext(),
        processManager: processManager,
      );

      await command.runWith(
        MockContext(),
        InitArgs(
          packageDir: tempDir.path,
          outputDir: tempDir.path,
          empty: true,
        ),
      );

      final commands = verify(
        () => processManager.run(
          captureAny(),
          workingDirectory: any(named: 'workingDirectory'),
          runInShell: any(named: 'runInShell'),
        ),
      ).captured.cast<List<Object>>();
      final pubAdd = commands.singleWhere(
        (command) => command.take(3).join(' ') == 'flutter pub add',
      );
      expect(pubAdd, contains('material_ui'));

      final config = File(
        p.join(tempDir.path, 'widgetbook', 'lib', 'widgetbook.config.dart'),
      ).readAsStringSync();
      expect(
        config,
        contains("import 'package:material_ui/material_ui.dart';"),
      );
      expect(config, contains('MaterialThemeAddon('));
    });
  });
}
