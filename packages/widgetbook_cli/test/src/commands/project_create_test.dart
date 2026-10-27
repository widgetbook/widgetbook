import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/api/cloud_exception.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/fake_http_adapter.dart';
import '../../helper/mocks.dart';

void main() {
  group('$ProjectCreateCommand', () {
    const apiKey = 'widgetbook_secret';
    const existsMessage =
        'A project with this name already exists in this workspace.';
    const workspacesResponse = FakeResponse(200, {
      'workspaces': [
        {'id': 'workspace-1', 'name': 'My Workspace'},
      ],
    });
    const createdResponse = FakeResponse(201, {
      'id': 'project-1',
      'name': 'my-app',
      'createdAt': '2026-01-02T03:04:05.000Z',
    });

    late Logger logger;
    late Progress progress;
    late Context context;

    setUp(() {
      logger = MockLogger();
      progress = MockProgress();
      context = MockContext();

      when(() => logger.progress(any<String>())).thenReturn(progress);
    });

    Future<int?> run(FakeHttpAdapter adapter, List<String> args) {
      final command = ProjectCreateCommand(
        context: context,
        logger: logger,
        cloudClient: WidgetbookHttpClient()..client.httpClientAdapter = adapter,
      );
      final runner = CommandRunner<int>('widgetbook', 'CLI')
        ..addCommand(command);

      return runner.run(['create', ...args]);
    }

    test('creates the project in the workspace of the key', () async {
      final adapter = FakeHttpAdapter([workspacesResponse, createdResponse]);

      final exitCode = await run(adapter, [
        '--api-key',
        apiKey,
        '--project',
        'my-app',
      ]);

      expect(exitCode, equals(ExitCode.success.code));
      verify(() => progress.complete("Project 'my-app' created.")).called(1);

      final [workspaces, create] = adapter.requests;
      expect(workspaces.method, equals('GET'));
      expect(workspaces.uri.path, equals('/v4/workspaces'));
      expect(create.method, equals('POST'));
      expect(create.uri.path, equals('/v4/workspaces/workspace-1/projects'));
      expect(create.body, equals({'name': 'my-app'}));
      for (final request in adapter.requests) {
        expect(request.header('Authorization'), equals('Bearer $apiKey'));
      }
    });

    for (final legacyKey in ['project-key', 'widgetbook_ws_secret']) {
      test('sends any key to the server: $legacyKey', () async {
        final adapter = FakeHttpAdapter([workspacesResponse, createdResponse]);

        await run(adapter, ['--api-key', legacyKey, '--project', 'my-app']);

        expect(
          adapter.requests.last.header('Authorization'),
          equals('Bearer $legacyKey'),
        );
      });
    }

    test('shows the missing scope of the key', () async {
      const detail = 'This API key lacks the scope PROJECTS_CREATE.';
      final adapter = FakeHttpAdapter([
        workspacesResponse,
        const FakeResponse(403, {'message': detail, 'statusCode': 403}),
      ]);

      await expectLater(
        run(adapter, ['--api-key', apiKey, '--project', 'my-app']),
        throwsA(
          isA<CloudException>()
              .having((e) => e.statusCode, 'statusCode', 403)
              .having((e) => e.message, 'message', contains(detail)),
        ),
      );

      verify(() => progress.fail('Could not create the project')).called(1);
    });

    test('fails before any request for an empty project', () async {
      final adapter = FakeHttpAdapter([workspacesResponse]);

      await expectLater(
        run(adapter, ['--api-key', apiKey, '--project', ' ']),
        throwsA(
          isA<CliException>().having(
            (e) => e.message,
            'message',
            'The option project must not be empty.',
          ),
        ),
      );

      expect(adapter.requests, isEmpty);
    });

    const argsWithout = {
      'api-key': ['--project', 'my-app'],
      'project': ['--api-key', apiKey],
    };

    for (final MapEntry(key: missing, value: args) in argsWithout.entries) {
      test('requires $missing', () {
        expect(
          run(FakeHttpAdapter([workspacesResponse]), args),
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
      final adapter = FakeHttpAdapter([
        workspacesResponse,
        const FakeResponse(409, {'message': existsMessage}),
      ]);

      final exitCode = await run(adapter, [
        '--api-key',
        apiKey,
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
      final adapter = FakeHttpAdapter([
        workspacesResponse,
        const FakeResponse(409, {'message': existsMessage}),
      ]);

      await expectLater(
        run(adapter, ['--api-key', apiKey, '--project', 'my-app']),
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

    test('passes other errors through with --allow-existing', () async {
      final adapter = FakeHttpAdapter([
        const FakeResponse(401, {'message': 'Invalid API key.'}),
      ]);

      await expectLater(
        run(adapter, [
          '--api-key',
          apiKey,
          '--project',
          'my-app',
          '--allow-existing',
        ]),
        throwsA(
          isA<CloudException>()
              .having((e) => e.statusCode, 'statusCode', 401)
              .having((e) => e.detail, 'detail', 'Invalid API key.'),
        ),
      );
    });

    group('api-url', () {
      test('is shown in the usage', () {
        final command = ProjectCreateCommand(context: context);

        expect(command.argParser.options['api-url']!.hide, isFalse);
        expect(command.argParser.usage, contains('--api-url'));
      });

      test('is applied to the requests', () async {
        final adapter = FakeHttpAdapter([workspacesResponse, createdResponse]);

        await run(adapter, [
          '--api-key',
          apiKey,
          '--project',
          'my-app',
          '--api-url',
          'https://api.example.com/cloud',
        ]);

        for (final request in adapter.requests) {
          expect(request.uri.host, equals('api.example.com'));
          expect(request.uri.path, startsWith('/cloud/v4/workspaces'));
        }
      });
    });
  });
}
