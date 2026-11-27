@TestOn('vm')
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/commands/test.dart';
import 'package:widgetbook_cli/src/core/cli_exception.dart';
import 'package:widgetbook_cli/src/test/test_exit_codes.dart';

import '../../helper/mocks.dart';

class FakeProcess extends Fake implements Process {
  FakeProcess({this.exit = 0, String output = ''})
    : stdout = Stream.value(utf8.encode(output));

  final int exit;

  @override
  final Stream<List<int>> stdout;

  @override
  Stream<List<int>> get stderr => const Stream.empty();

  @override
  Future<int> get exitCode async => exit;

  @override
  bool kill([ProcessSignal signal = ProcessSignal.sigterm]) => true;
}

void main() {
  group('widgetbook test', () {
    late Directory root;
    late MockProcessManager processManager;

    /// The exit code and output of each executable, by its first argument.
    late Map<String, FakeProcess> processes;

    late bool buildRunnerRunning;

    void write(String path, String content) {
      File(p.join(root.path, path))
        ..createSync(recursive: true)
        ..writeAsStringSync(content);
    }

    setUpAll(() => registerFallbackValue(<String>[]));

    setUp(() {
      root = Directory.systemTemp.createTempSync('wb_test_command');
      write('test/widgetbook_test.dart', '');
      write('lib/counter.stories.dart', 'const meta = Meta(Counter.new);');
      write('lib/avatar.stories.dart', 'const meta = Meta(Avatar.new);');
      write('pubspec.lock', '''
packages:
  widgetbook:
    dependency: "direct main"
    source: hosted
    version: "4.0.0-beta.16"
''');

      processes = {};
      buildRunnerRunning = false;
      processManager = MockProcessManager();
      when(
        () => processManager.start(
          any(),
          workingDirectory: any(named: 'workingDirectory'),
          runInShell: any(named: 'runInShell'),
        ),
      ).thenAnswer((invocation) async {
        final command = invocation.positionalArguments.first as List<Object>;
        return processes[command.first] ?? FakeProcess();
      });
    });

    tearDown(() => root.deleteSync(recursive: true));

    /// Runs the command with [args] and returns its exit code.
    Future<int> run(List<String> args) async {
      final command = TestCommand(
        context: MockContext(),
        logger: MockLogger(),
        processManager: processManager,
        buildRunnerRunning: (packageDir) {
          expect(packageDir, root.path);
          return buildRunnerRunning;
        },
        workingDirectory: root.path,
      );

      final results = command.argParser.parse(args);
      final testArgs = await command.parseResults(MockContext(), results);
      return command.runWith(MockContext(), testArgs);
    }

    /// The commands started, in order.
    List<List<Object>> startedCommands() {
      return verify(
        () => processManager.start(
          captureAny(),
          workingDirectory: root.path,
          runInShell: any(named: 'runInShell'),
        ),
      ).captured.cast<List<Object>>();
    }

    Matcher throwsCliException(int exitCode, String message) {
      return throwsA(
        isA<CliException>()
            .having((e) => e.exitCode, 'exitCode', exitCode)
            .having((e) => e.message, 'message', contains(message)),
      );
    }

    test('runs build_runner, then every scenario', () async {
      expect(await run([]), 0);

      expect(startedCommands(), [
        ['dart', 'run', 'build_runner', 'build'],
        ['flutter', 'test', 'test/widgetbook_test.dart'],
      ]);
    });

    test('skips build_runner while another one is running', () async {
      buildRunnerRunning = true;

      expect(await run([]), 0);

      expect(startedCommands(), [
        ['flutter', 'test', 'test/widgetbook_test.dart'],
      ]);
    });

    test('selects the components of --path and --filter', () async {
      await run([
        '--path',
        'lib/counter.stories.dart',
        '--filter',
        'Avatar/Default',
      ]);

      expect(startedCommands().last, [
        'flutter',
        'test',
        'test/widgetbook_test.dart',
        '--name',
        '^(?:Counter |Avatar Default )',
      ]);
    });

    test('passes --no-snapshots, --target and the rest', () async {
      write('test/catalog_test.dart', '');

      await run([
        '--no-build-runner',
        '--no-snapshots',
        '--target',
        'test/catalog_test.dart',
        '--filter',
        'Counter',
        '--',
        '--reporter',
        'expanded',
      ]);

      expect(startedCommands(), [
        [
          'flutter',
          'test',
          'test/catalog_test.dart',
          '--name',
          '^Counter ',
          '--dart-define=WIDGETBOOK_SNAPSHOTS=false',
          '--reporter',
          'expanded',
        ],
      ]);
    });

    test('returns the exit code of flutter test', () async {
      processes['flutter'] = FakeProcess(exit: 1);

      expect(await run(['--filter', 'Counter']), 1);
    });

    test('stops when build_runner fails', () async {
      processes['dart'] = FakeProcess(exit: 1);

      await expectLater(
        run([]),
        throwsCliException(
          TestExitCodes.buildRunnerFailed,
          'build_runner failed with exit code 1',
        ),
      );
      expect(startedCommands(), hasLength(1));
    });

    test('names the selection that ran no scenarios', () async {
      processes['flutter'] = FakeProcess(exit: 79);

      await expectLater(
        run(['--no-build-runner', '--path', 'lib/counter.stories.dart']),
        throwsCliException(
          TestExitCodes.noTestsRan,
          'Component "Counter" (lib/counter.stories.dart) ran no scenarios; '
          'its generated code may be stale. Run without --no-build-runner.',
        ),
      );
    });

    test('does not blame stale code when build_runner ran', () async {
      processes['flutter'] = FakeProcess(exit: 79);

      await expectLater(
        run(['--filter', 'Countr']),
        throwsCliException(
          TestExitCodes.noTestsRan,
          '"Countr" ran no scenarios; check that the names match',
        ),
      );
    });

    test('fails when every matched scenario is skipped', () async {
      processes['flutter'] = FakeProcess(
        output:
            '00:01 +0 ~2: Counter Default x\r00:01 +0 ~2: '
            'All tests skipped.\n',
      );

      await expectLater(
        run(['--filter', 'Counter']),
        throwsCliException(
          TestExitCodes.allSkipped,
          'All scenarios of "Counter" are excluded via excludeFromTests',
        ),
      );
    });

    test('rejects a missing target before running anything', () async {
      await expectLater(
        run(['--target', 'test/missing_test.dart']),
        throwsCliException(
          TestExitCodes.pathNotFound,
          'test/missing_test.dart not found',
        ),
      );
      verifyNever(
        () => processManager.start(
          any(),
          workingDirectory: any(named: 'workingDirectory'),
          runInShell: any(named: 'runInShell'),
        ),
      );
    });

    test('rejects a missing path before running anything', () async {
      await expectLater(
        run(['--path', 'lib/missing.stories.dart']),
        throwsCliException(TestExitCodes.pathNotFound, 'not found'),
      );
    });

    test('rejects --no-snapshots on an older widgetbook', () async {
      write('pubspec.lock', '''
packages:
  widgetbook:
    source: hosted
    version: "4.0.0-beta.15"
''');

      await expectLater(
        run(['--no-snapshots']),
        throwsCliException(
          TestExitCodes.unsupportedVersion,
          '--no-snapshots requires widgetbook >= 4.0.0-beta.16',
        ),
      );
    });

    test('does not check the version without --no-snapshots', () async {
      File(p.join(root.path, 'pubspec.lock')).deleteSync();

      expect(await run([]), 0);
    });
  });
}
