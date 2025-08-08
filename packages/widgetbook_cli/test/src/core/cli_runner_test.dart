import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';
import '../../helper/override_print.dart';

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
      '  cloud      Manage your Widgetbook Cloud projects.\n'
      '  coverage   Checks the percentage of package widgets that are covered by at least one use-case in Widgetbook.\n'
      '  upgrade    Upgrade Widgetbook CLI\n'
      '\n'
      'Run "widgetbook help <command>" for more information about a command.',
];

const latestVersion = '0.0.0';
final changelogLink = lightCyan.wrap(
  styleUnderlined.wrap(
    link(
      uri: Uri.parse(
        'https://pub.dev/packages/widgetbook_cli/versions/$latestVersion/changelog',
      ),
    ),
  ),
);

final updateMessage =
    '\n${lightYellow.wrap('Update available!')} '
    '${lightCyan.wrap(packageVersion)} \u2192 ${lightCyan.wrap(latestVersion)}\n'
    '${lightYellow.wrap('Changelog:')} $changelogLink\n'
    'Run ${cyan.wrap('${cliName} update')} to update';

void main() {
  group('$CliRunner', () {
    late Logger logger;
    late Progress progress;
    late PubUpdater pubUpdater;
    late CliRunner cliRunner;
    late Context globalContext;

    setUp(() {
      printLogs = [];
      progress = MockProgress();
      logger = MockLogger();
      pubUpdater = MockPubUpdater();
      globalContext = MockContext();

      when(() => logger.progress(any<String>())).thenReturn(progress);

      when(
        () => pubUpdater.getLatestVersion(any()),
      ).thenAnswer((_) async => packageVersion);

      cliRunner = CliRunner(
        context: globalContext,
        logger: logger,
        pubUpdater: pubUpdater,
      );
    });

    group('run', () {
      test('prompts for update when newer version exists', () async {
        when(
          () => pubUpdater.isUpToDate(
            packageName: packageName,
            currentVersion: packageVersion,
          ),
        ).thenAnswer((_) async => false);
        when(
          () => pubUpdater.getLatestVersion(any()),
        ).thenAnswer((_) async => latestVersion);

        final result = await cliRunner.run(['--version']);
        expect(result, equals(ExitCode.success.code));

        verify(() => logger.info(updateMessage)).called(1);
      });

      test('handles pub update errors gracefully', () async {
        when(
          () => pubUpdater.getLatestVersion(any()),
        ).thenThrow(Exception('oops'));

        final result = await cliRunner.run(['--version']);
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
        final result = await cliRunner.run(['--version']);
        expect(result, equals(ExitCode.usage.code));
        verify(() => logger.err(exception.message)).called(1);
        verify(() => logger.info(cliRunner.usage)).called(1);
      });

      test('handles UsageException', () async {
        final exception = UsageException('oops!', cliRunner.usage);
        var isFirstInvocation = true;
        when(() => logger.info(any())).thenAnswer((_) {
          if (isFirstInvocation) {
            isFirstInvocation = false;
            throw exception;
          }
        });
        final result = await cliRunner.run(['--version']);
        expect(result, equals(ExitCode.usage.code));
        verify(() => logger.err(exception.message)).called(1);
        verify(() => logger.info(cliRunner.usage)).called(1);
      });

      test(
        'handles no command',
        overridePrint(() async {
          final result = await cliRunner.run([]);
          expect(printLogs, equals(expectedUsage));
          expect(result, equals(ExitCode.success.code));
        }),
      );

      group('--help', () {
        test(
          'outputs usage',
          overridePrint(() async {
            final result = await cliRunner.run(['--help']);
            expect(printLogs, equals(expectedUsage));
            expect(result, equals(ExitCode.success.code));

            printLogs.clear();

            final resultAbbr = await cliRunner.run(['-h']);
            expect(printLogs, equals(expectedUsage));
            expect(resultAbbr, equals(ExitCode.success.code));
          }),
        );
      });

      group('--version', () {
        test('outputs current version', () async {
          final result = await cliRunner.run(['--version']);
          expect(result, equals(ExitCode.success.code));
          verify(() => logger.info(packageVersion)).called(1);
        });
      });
    });
  });
}
