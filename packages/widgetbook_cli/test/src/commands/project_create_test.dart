import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/api/cloud_exception.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';

void main() {
  group('$ProjectCreateCommand', () {
    const apiKey = 'widgetbook_secret';
    const existsMessage =
        'A project with this name already exists in this workspace.';

    late Progress progress;
    late MockWidgetbookHttpClient client;
    late CommandRunner<int> runner;

    setUpAll(() {
      registerFallbackValue(const CreateProjectRequest(name: 'my-app'));
    });

    setUp(() {
      final logger = MockLogger();
      progress = MockProgress();
      when(() => logger.progress(any<String>())).thenReturn(progress);

      client = MockWidgetbookHttpClient();
      when(
        () => client.resolveWorkspaceId(any()),
      ).thenAnswer((_) async => 'workspace-1');

      runner = CommandRunner<int>('widgetbook', 'CLI')
        ..addCommand(
          ProjectCreateCommand(
            context: MockContext(),
            logger: logger,
            cloudClient: client,
          ),
        );
    });

    Future<int?> run(List<String> args) {
      return runner.run(['create', '--api-key', apiKey, ...args]);
    }

    void stubCreateProject409() {
      when(() => client.createProject(any(), any(), any())).thenThrow(
        CloudException(existsMessage, statusCode: 409),
      );
    }

    test('creates the project in the workspace of the key', () async {
      when(() => client.createProject(any(), any(), any())).thenAnswer(
        (_) async => ProjectResponse(
          id: 'project-1',
          name: 'my-app',
          createdAt: DateTime.utc(2026),
        ),
      );

      final exitCode = await run(['--project', 'my-app']);

      expect(exitCode, equals(ExitCode.success.code));
      verify(() => progress.complete("Project 'my-app' created.")).called(1);

      final request =
          verify(
                () => client.createProject(apiKey, 'workspace-1', captureAny()),
              ).captured.single
              as CreateProjectRequest;
      expect(request.name, equals('my-app'));
    });

    test('fails for an existing project without --allow-existing', () async {
      stubCreateProject409();

      await expectLater(
        run(['--project', 'my-app']),
        throwsA(
          isA<CliException>().having(
            (e) => e.message,
            'message',
            allOf(contains(existsMessage), contains('--allow-existing')),
          ),
        ),
      );
    });

    test('succeeds for an existing project with --allow-existing', () async {
      stubCreateProject409();

      final exitCode = await run(['--project', 'my-app', '--allow-existing']);

      expect(exitCode, equals(ExitCode.success.code));
      verify(
        () => progress.complete("Project 'my-app' already exists."),
      ).called(1);
    });

    test('fails before any request for a blank project', () async {
      await expectLater(
        run(['--project', ' ']),
        throwsA(
          isA<CliException>().having(
            (e) => e.message,
            'message',
            'The option project must not be empty.',
          ),
        ),
      );

      verifyZeroInteractions(client);
    });
  });
}
