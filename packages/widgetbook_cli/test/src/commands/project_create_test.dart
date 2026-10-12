import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/api/cloud_exception.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';

class _FakeCreateProjectRequest extends Fake implements CreateProjectRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeCreateProjectRequest());
  });

  group('$ProjectCreateCommand', () {
    const workspaceKey = 'widgetbook_ws_secret';
    const existsMessage =
        'A project with this name already exists in this workspace.';

    late Logger logger;
    late Progress progress;
    late Context context;
    late MockWidgetbookHttpClient client;
    late ProjectCreateCommand command;
    late CommandRunner<int> runner;

    setUp(() {
      logger = MockLogger();
      progress = MockProgress();
      context = MockContext();
      client = MockWidgetbookHttpClient();

      when(() => logger.progress(any<String>())).thenReturn(progress);

      command = ProjectCreateCommand(
        context: context,
        logger: logger,
        cloudClient: client,
      );
      runner = CommandRunner<int>('widgetbook', 'CLI')..addCommand(command);
    });

    Future<int?> run(List<String> args) => runner.run(['create', ...args]);

    Matcher throwsCliException(Object message) {
      return throwsA(
        isA<CliException>().having((e) => e.message, 'message', message),
      );
    }

    test('creates the project', () async {
      when(() => client.createProject(any())).thenAnswer(
        (_) async => CreateProjectResponse(
          id: 'project-1',
          name: 'my-app',
          createdAt: DateTime.utc(2026),
        ),
      );

      final exitCode = await run([
        '--api-key',
        workspaceKey,
        '--project',
        'my-app',
      ]);

      expect(exitCode, equals(ExitCode.success.code));
      verify(() => progress.complete("Project 'my-app' created.")).called(1);

      final request =
          verify(() => client.createProject(captureAny())).captured.single
              as CreateProjectRequest;
      expect(request.apiKey.value, equals(workspaceKey));
      expect(request.name, equals('my-app'));
    });

    test('fails before any request for a project key', () async {
      await expectLater(
        run(['--api-key', 'project-key', '--project', 'my-app']),
        throwsCliException(
          startsWith('Creating a project requires a workspace API key'),
        ),
      );

      verifyZeroInteractions(client);
    });

    test('fails before any request for an empty project', () async {
      await expectLater(
        run(['--api-key', workspaceKey, '--project', ' ']),
        throwsCliException('The option project must not be empty.'),
      );

      verifyZeroInteractions(client);
    });

    const argsWithout = {
      'api-key': ['--project', 'my-app'],
      'project': ['--api-key', workspaceKey],
    };

    for (final MapEntry(key: missing, value: args) in argsWithout.entries) {
      test('requires $missing', () {
        expect(
          run(args),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              'Option $missing is mandatory.',
            ),
          ),
        );
      });
    }

    test('succeeds for an existing project with --allow-existing', () async {
      when(() => client.createProject(any())).thenThrow(
        CloudException(existsMessage, statusCode: 409),
      );

      final exitCode = await run([
        '--api-key',
        workspaceKey,
        '--project',
        'my-app',
        '--allow-existing',
      ]);

      expect(exitCode, equals(ExitCode.success.code));
      verify(
        () => progress.complete("Project 'my-app' already exists."),
      ).called(1);
    });

    test('fails for an existing project without --allow-existing', () async {
      when(() => client.createProject(any())).thenThrow(
        CloudException(existsMessage, statusCode: 409),
      );

      await expectLater(
        run(['--api-key', workspaceKey, '--project', 'my-app']),
        throwsA(
          isA<CliException>()
              .having((e) => e.exitCode, 'exitCode', isNot(0))
              .having(
                (e) => e.message,
                'message',
                allOf(contains(existsMessage), contains('--allow-existing')),
              ),
        ),
      );
    });

    test('passes other errors through', () async {
      final error = CloudException('Invalid API key.', statusCode: 401);
      when(() => client.createProject(any())).thenThrow(error);

      await expectLater(
        run([
          '--api-key',
          workspaceKey,
          '--project',
          'my-app',
          '--allow-existing',
        ]),
        throwsA(same(error)),
      );
    });

    group('api-url', () {
      test('is shown in the usage', () {
        expect(command.argParser.options['api-url']!.hide, isFalse);
        expect(command.argParser.usage, contains('--api-url'));
      });

      test('sets the base URL', () {
        final command = ProjectCreateCommand(context: context);

        command.argParser.parse(['--api-url', 'https://api.example.com']);

        expect(
          command.cloudClient.client.options.baseUrl,
          equals('https://api.example.com/'),
        );
      });
    });
  });
}
