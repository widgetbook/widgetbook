// ignore_for_file: no_adjacent_strings_in_list
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:test/test.dart';

import '../../bin/app/widgetbook_command_runner.dart';
import '../../bin/helpers/helpers.dart';
import '../mocks/mocks.dart';
import '../utils/utils.dart';

const expectedUsage = [
  'Widgetbook CLI\n'
      '\n'
      'Usage: widgetbook <command> [arguments]\n'
      '\n'
      'Global options:\n'
      '-h, --help       Print this usage information.\n'
      '    --version    Print the current version.\n'
      '\n'
      'Available commands:\n'
      '  publish   Publish a new build\n'
      '  upgrade   Upgrade Widgetbook CLI\n'
      '\n'
      'Run "widgetbook help <command>" for more information about a command.'
];

const latestVersion = '0.0.0';
final changelogLink = lightCyan.wrap(
  styleUnderlined.wrap(
    link(
      uri: Uri.parse(
        'https://pub.dev/packages/widgetbook_cli/changelog',
      ),
    ),
  ),
);
final updateMessage = '''
${lightYellow.wrap('Update available!')} ${lightCyan.wrap(packageVersion)} \u2192 ${lightCyan.wrap(latestVersion)}
${lightYellow.wrap('Changelog:')} $changelogLink
Run ${cyan.wrap('widgetbook update')} to update''';

void main() {
  group('$WidgetbookCommandRunner', () {
    late Logger logger;
    late Progress progress;

    late PubUpdater pubUpdater;
    late WidgetbookCommandRunner commandRunner;

    setUp(() {
      printLogs = [];
      progress = MockProgress();
      logger = MockLogger();
      when(() => logger.progress(any<String>())).thenReturn(progress);

      pubUpdater = MockPubUpdater();

      when(
        () => pubUpdater.getLatestVersion(any()),
      ).thenAnswer((_) async => packageVersion);

      commandRunner = WidgetbookCommandRunner(
        logger: logger,
        pubUpdater: pubUpdater,
      );
    });

    test('can be instantiated without an explicit logger instance', () {
      expect(WidgetbookCommandRunner.new, returnsNormally);
    });

    group('run', () {
      test('prompts for update when newer version exists', () async {
        when(
          () => pubUpdater.getLatestVersion(any()),
        ).thenAnswer((_) async => latestVersion);
        final result = await commandRunner.run(['--version']);
        expect(result, equals(ExitCode.success.code));
        verify(() => logger.info(updateMessage)).called(1);
      });

      test('handles pub update errors gracefully', () async {
        when(
          () => pubUpdater.getLatestVersion(any()),
        ).thenThrow(Exception('oops'));

        final result = await commandRunner.run(['--version']);
        expect(result, equals(ExitCode.success.code));
        verifyNever(() => logger.info(updateMessage));
      });

      test('handles FormatException', () async {
        const exception = FormatException('oops!');
        var isFirstInvocation = true;
        when(() => logger.info(any())).thenAnswer((_) {
          if (isFirstInvocation) {
            isFirstInvocation = false;
            throw exception;
          }
        });
        final result = await commandRunner.run(['--version']);
        expect(result, equals(ExitCode.usage.code));
        verify(() => logger.err(exception.message)).called(1);
        verify(() => logger.info(commandRunner.usage)).called(1);
      });

      test('handles UsageException', () async {
        final exception = UsageException('oops!', commandRunner.usage);
        var isFirstInvocation = true;
        when(() => logger.info(any())).thenAnswer((_) {
          if (isFirstInvocation) {
            isFirstInvocation = false;
            throw exception;
          }
        });
        final result = await commandRunner.run(['--version']);
        expect(result, equals(ExitCode.usage.code));
        verify(() => logger.err(exception.message)).called(1);
        verify(() => logger.info(commandRunner.usage)).called(1);
      });

      test(
        'handles no command',
        overridePrint(() async {
          final result = await commandRunner.run([]);
          expect(printLogs, equals(expectedUsage));
          expect(result, equals(ExitCode.success.code));
        }),
      );

      group('--help', () {
        test(
          'outputs usage',
          overridePrint(() async {
            final result = await commandRunner.run(['--help']);
            expect(printLogs, equals(expectedUsage));
            expect(result, equals(ExitCode.success.code));

            printLogs.clear();

            final resultAbbr = await commandRunner.run(['-h']);
            expect(printLogs, equals(expectedUsage));
            expect(resultAbbr, equals(ExitCode.success.code));
          }),
        );
      });

      group('--version', () {
        test('outputs current version', () async {
          final result = await commandRunner.run(['--version']);
          expect(result, equals(ExitCode.success.code));
          verify(() => logger.info(packageVersion)).called(1);
        });
      });
    });
  });
}
