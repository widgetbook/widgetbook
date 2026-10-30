import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';

void main() {
  group('$ProjectConnectCommand', () {
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
      registerFallbackValue(
        const ConnectRepositoryRequest(provider: 'github', repository: 'a/b'),
      );
    });

    setUp(() {
      final logger = MockLogger();
      progress = MockProgress();
      when(() => logger.progress(any<String>())).thenReturn(progress);

      client = MockWidgetbookHttpClient();
      when(
        () => client.resolveProject(any(), name: any(named: 'name')),
      ).thenAnswer((_) async => project);
      when(() => client.connectRepository(any(), any(), any())).thenAnswer(
        (_) async => const ConnectRepositoryResponse(
          provider: 'github',
          repository: 'widgetbook/app',
        ),
      );

      runner = CommandRunner<int>('widgetbook', 'CLI')
        ..addCommand(
          ProjectConnectCommand(
            context: MockContext(),
            logger: logger,
            cloudClient: client,
          ),
        );
    });

    Future<int?> run(List<String> args) {
      return runner.run(['connect', '--api-key', apiKey, ...args]);
    }

    test('connects the named project to the repository', () async {
      final exitCode = await run([
        '--project',
        'my-app',
        '--repository',
        'widgetbook/app',
      ]);

      expect(exitCode, equals(ExitCode.success.code));
      verify(() => client.resolveProject(apiKey, name: 'my-app')).called(1);
      verify(
        () => progress.complete(
          "Connected project 'my-app' to widgetbook/app.",
        ),
      ).called(1);

      final request =
          verify(
                () => client.connectRepository(apiKey, project, captureAny()),
              ).captured.single
              as ConnectRepositoryRequest;
      expect(request.provider, equals('github'));
      expect(request.repository, equals('widgetbook/app'));
    });

    test('resolves without a name when --project is absent', () async {
      await run(['--repository', 'widgetbook/app']);

      verify(() => client.resolveProject(apiKey)).called(1);
    });

    for (final repository in ['widgetbook', 'widgetbook/app/x', '/app']) {
      test('fails before any request for repository "$repository"', () async {
        await expectLater(
          run(['--repository', repository]),
          throwsA(
            isA<CliException>()
                .having((e) => e.exitCode, 'exitCode', ExitCode.usage.code)
                .having(
                  (e) => e.message,
                  'message',
                  startsWith('The option repository must have the form'),
                ),
          ),
        );

        verifyZeroInteractions(client);
      });
    }

    test('fails before any request for an unsupported provider', () async {
      await expectLater(
        run(['--repository', 'widgetbook/app', '--provider', 'gitlab']),
        throwsA(isA<UsageException>()),
      );

      verifyZeroInteractions(client);
    });
  });
}
