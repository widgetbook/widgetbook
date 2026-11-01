import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';

void main() {
  group('$ProjectDisconnectCommand', () {
    const apiKey = 'widgetbook_secret';
    late Progress progress;
    late MockWidgetbookHttpClient client;
    late CommandRunner<int> runner;

    setUp(() {
      final logger = MockLogger();
      progress = MockProgress();
      when(() => logger.progress(any<String>())).thenReturn(progress);

      client = MockWidgetbookHttpClient();
      when(
        () => client.disconnectRepository(
          any(),
          projectName: any(named: 'projectName'),
        ),
      ).thenAnswer((_) async {});

      runner = CommandRunner<int>('widgetbook', 'CLI')
        ..addCommand(
          ProjectDisconnectCommand(
            context: MockContext(),
            logger: logger,
            cloudClient: client,
          ),
        );
    });

    Future<int?> run(List<String> args) {
      return runner.run(['disconnect', '--api-key', apiKey, ...args]);
    }

    test('disconnects the named project', () async {
      final exitCode = await run(['--project', 'my-app']);

      expect(exitCode, equals(ExitCode.success.code));
      verify(
        () => client.disconnectRepository(apiKey, projectName: 'my-app'),
      ).called(1);
      verify(
        () => progress.complete(
          "Disconnected project 'my-app' from its repository.",
        ),
      ).called(1);
    });

    test('disconnects the only project without --project', () async {
      await run([]);

      verify(() => client.disconnectRepository(apiKey)).called(1);
      verify(
        () => progress.complete("Disconnected the project's repository."),
      ).called(1);
    });
  });
}
