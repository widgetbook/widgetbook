import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';

void main() {
  const latestVersion = '0.0.0';

  group('widgetbook upgrade', () {
    late Logger logger;
    late PubUpdater pubUpdater;
    late CliRunner cliRunner;
    late Context globalContext;

    setUp(() {
      globalContext = MockContext();
      logger = MockLogger();
      pubUpdater = MockPubUpdater();

      when(() => logger.progress(any())).thenReturn(MockProgress());
      when(
        () => pubUpdater.update(packageName: packageName),
      ).thenAnswer((_) => Future.value(MockProcessResult.success('')));

      cliRunner = CliRunner(
        context: globalContext,
        logger: logger,
        pubUpdater: pubUpdater,
      );
    });

    test('handles pub latest version query errors', () async {
      when(
        () => pubUpdater.isUpToDate(
          packageName: any(named: 'packageName'),
          currentVersion: any(named: 'currentVersion'),
        ),
      ).thenThrow(Exception('oops'));

      final result = await cliRunner.run(['upgrade']);
      expect(result, equals(ExitCode.software.code));
      verify(() => logger.progress('Checking for updates')).called(1);
      verify(() => logger.err('Exception: oops'));
      verifyNever(
        () => pubUpdater.update(packageName: any(named: 'packageName')),
      );
    });

    test('handles pub update errors', () async {
      when(
        () => pubUpdater.isUpToDate(
          packageName: any(named: 'packageName'),
          currentVersion: any(named: 'currentVersion'),
        ),
      ).thenAnswer((_) async => false);

      when(
        () => pubUpdater.getLatestVersion(packageName),
      ).thenAnswer((_) async => latestVersion);

      when(
        () => pubUpdater.update(
          packageName: any(named: 'packageName'),
        ),
      ).thenThrow(Exception('oops'));

      final result = await cliRunner.run(['upgrade']);
      expect(result, equals(ExitCode.software.code));
      verify(() => logger.progress('Checking for updates')).called(1);
      verify(() => logger.err('Exception: oops'));
      verify(
        () => pubUpdater.update(packageName: any(named: 'packageName')),
      ).called(1);
    });

    test('updates when newer version exists', () async {
      when(
        () => pubUpdater.isUpToDate(
          packageName: any(named: 'packageName'),
          currentVersion: any(named: 'currentVersion'),
        ),
      ).thenAnswer((_) async => false);

      when(
        () => pubUpdater.getLatestVersion(any()),
      ).thenAnswer((_) async => latestVersion);

      when(() => logger.progress(any())).thenReturn(MockProgress());

      final result = await cliRunner.run(['upgrade']);
      expect(result, equals(ExitCode.success.code));
      verify(() => logger.progress('Checking for updates')).called(1);
      verify(() => logger.progress('Upgrading to latest version')).called(1);
      verify(
        () => pubUpdater.update(
          packageName: packageName,
        ),
      ).called(1);
    });

    test('does not update when already on latest version', () async {
      when(
        () => pubUpdater.isUpToDate(
          packageName: any(named: 'packageName'),
          currentVersion: any(named: 'currentVersion'),
        ),
      ).thenAnswer((_) async => true);

      when(
        () => pubUpdater.getLatestVersion(any()),
      ).thenAnswer((_) async => packageVersion);
      when(() => logger.progress(any())).thenReturn(MockProgress());
      final result = await cliRunner.run(['upgrade']);
      expect(result, equals(ExitCode.success.code));
      verify(
        () => logger.info('Widgetbook CLI is already at the latest version.'),
      ).called(1);
      verifyNever(() => logger.progress('Upgrading to $latestVersion'));
      verifyNever(() => pubUpdater.update(packageName: packageName));
    });
  });
}
