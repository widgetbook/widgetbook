import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';

void main() {
  group('$ProjectDisconnectCommand', () {
    const apiKey = 'widgetbook_secret';
    const project = CloudProject(
      workspaceId: 'workspace-1',
      projectId: 'project-1',
      name: 'my-app',
    );

    late Progress progress;
    late MockWidgetbookHttpClient client;
    late CommandRunner<int> runner;

    setUpAll(() {
      registerFallbackValue(project);
    });

    setUp(() {
      final logger = MockLogger();
      progress = MockProgress();
      when(() => logger.progress(any<String>())).thenReturn(progress);

      client = MockWidgetbookHttpClient();
      when(
        () => client.resolveProject(any(), name: any(named: 'name')),
      ).thenAnswer((_) async => project);
      when(
        () => client.disconnectRepository(any(), any()),
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
      verify(() => client.resolveProject(apiKey, name: 'my-app')).called(1);
      verify(() => client.disconnectRepository(apiKey, project)).called(1);
      verify(
        () => progress.complete(
          "Disconnected project 'my-app' from its repository.",
        ),
      ).called(1);
    });

    test('resolves without a name when --project is absent', () async {
      await run([]);

      verify(() => client.resolveProject(apiKey)).called(1);
    });
  });
}
