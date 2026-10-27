import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/api/cloud_exception.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/fake_http_adapter.dart';
import '../../helper/mocks.dart';

void main() {
  group('$ReviewSkipCommand', () {
    const apiKey = 'widgetbook_secret';
    const headSha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';
    const workspacesResponse = FakeResponse(200, {
      'workspaces': [
        {'id': 'workspace-1', 'name': 'My Workspace'},
      ],
    });
    const projectsResponse = FakeResponse(200, {
      'projects': [
        {
          'id': 'project-1',
          'name': 'my-app',
          'createdAt': '2026-01-02T03:04:05.000Z',
        },
      ],
    });
    const skipResponse = FakeResponse(200, {
      'sha': headSha,
      'state': 'success',
      'prNumber': 123,
    });

    late Logger logger;
    late Context context;

    setUp(() {
      logger = MockLogger();
      when(() => logger.progress(any<String>())).thenReturn(MockProgress());

      context = MockContext();
    });

    group('parseResults', () {
      late ArgResults results;
      late ReviewSkipCommand command;

      setUp(() {
        results = MockArgResults();
        command = ReviewSkipCommand(context: context, logger: logger);

        when(() => results['api-key']).thenReturn(apiKey);
        when(() => results['pr']).thenReturn('123');
        when(() => results['sha']).thenReturn(headSha);
        when(() => results['reason']).thenReturn('No UI changes');
      });

      test('parses the passed options', () async {
        final args = await command.parseResults(context, results);

        expect(args.apiKey, equals(apiKey));
        expect(args.project, isNull);
        expect(args.prNumber, equals(123));
        expect(args.sha, equals(headSha));
        expect(args.reason, equals('No UI changes'));
      });

      test('parses the project', () async {
        when(() => results['project']).thenReturn('my-app');

        final args = await command.parseResults(context, results);

        expect(args.project, equals('my-app'));
      });

      test('throws for an empty project', () {
        when(() => results['project']).thenReturn(' ');

        expect(
          () => command.parseResults(context, results),
          throwsA(
            isA<CliException>().having(
              (e) => e.message,
              'message',
              'The option project must not be empty.',
            ),
          ),
        );
      });

      test('throws when the pull request number is not a number', () {
        when(() => results['pr']).thenReturn('not-a-number');

        expect(
          () => command.parseResults(context, results),
          throwsA(isA<CliException>()),
        );
      });
    });

    group('run', () {
      Future<int?> run(FakeHttpAdapter adapter, List<String> args) {
        final command = ReviewSkipCommand(
          context: context,
          logger: logger,
          cloudClient: WidgetbookHttpClient()
            ..client.httpClientAdapter = adapter,
        );
        final runner = CommandRunner<int>('widgetbook', 'CLI')
          ..addCommand(command);

        return runner.run([
          'skip',
          '--api-key',
          apiKey,
          '--pr',
          '123',
          '--sha',
          headSha,
          ...args,
        ]);
      }

      void expectSkipRequest(RecordedRequest request) {
        expect(request.method, equals('POST'));
        expect(
          request.uri.path,
          equals(
            '/v4/workspaces/workspace-1/projects/project-1'
            '/pull-requests/123/review-skip',
          ),
        );
        expect(request.body, equals({'sha': headSha, 'reason': 'No UI'}));
      }

      test('skips the review of the named project', () async {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          projectsResponse,
          skipResponse,
        ]);

        final exitCode = await run(adapter, [
          '--project',
          'my-app',
          '--reason',
          'No UI',
        ]);

        expect(exitCode, equals(ExitCode.success.code));

        final [workspaces, projects, skip] = adapter.requests;
        expect(workspaces.uri.path, equals('/v4/workspaces'));
        expect(
          projects.uri.path,
          equals('/v4/workspaces/workspace-1/projects'),
        );
        expect(projects.uri.queryParameters, equals({'name': 'my-app'}));
        expectSkipRequest(skip);
        for (final request in adapter.requests) {
          expect(request.header('Authorization'), equals('Bearer $apiKey'));
        }
      });

      test('skips the review of the only project without --project', () async {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          projectsResponse,
          skipResponse,
        ]);

        await run(adapter, ['--reason', 'No UI']);

        final [_, projects, skip] = adapter.requests;
        expect(projects.uri.queryParameters, isEmpty);
        expectSkipRequest(skip);
      });

      test('points to project create for an unknown project', () async {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          const FakeResponse(200, {'projects': <dynamic>[]}),
        ]);

        await expectLater(
          run(adapter, ['--project', 'my-app']),
          throwsA(
            isA<CliException>().having(
              (e) => e.message,
              'message',
              "No project named 'my-app'. "
                  'Create it with: '
                  'widgetbook cloud project create --project my-app',
            ),
          ),
        );

        expect(adapter.requests, hasLength(2));
      });

      test('retries a pull request that is not synced yet', () async {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          projectsResponse,
          const FakeResponse(404, {
            'message': 'No pull request #123 is known for this project.',
          }),
          skipResponse,
        ]);
        final command = ReviewSkipCommand(
          context: context,
          logger: logger,
          cloudClient: WidgetbookHttpClient()
            ..client.httpClientAdapter = adapter,
        );

        await command.runWith(
          context,
          const ReviewSkipArgs(
            apiKey: apiKey,
            project: null,
            prNumber: 123,
            sha: headSha,
            reason: null,
          ),
        );

        expect(adapter.requests, hasLength(4));
      }, timeout: const Timeout(Duration(seconds: 10)));

      const notRetried = [
        (404, 'Workspace not found.'),
        (404, 'Project not found.'),
        (403, 'This API key has no access to this project.'),
        (422, 'Validation failed.'),
      ];

      for (final (statusCode, detail) in notRetried) {
        test('does not retry a $statusCode: $detail', () async {
          final adapter = FakeHttpAdapter([
            workspacesResponse,
            projectsResponse,
            FakeResponse(statusCode, {'message': detail}),
            skipResponse,
          ]);

          await expectLater(
            run(adapter, []),
            throwsA(
              isA<CloudException>()
                  .having((e) => e.statusCode, 'statusCode', statusCode)
                  .having((e) => e.message, 'message', contains(detail)),
            ),
          );

          expect(adapter.requests, hasLength(3));
        });
      }
    });

    group('api-url', () {
      test('is shown in the usage', () {
        final command = ReviewSkipCommand(context: context);

        expect(command.argParser.options['api-url']!.hide, isFalse);
        expect(command.argParser.usage, contains('--api-url'));
      });

      test('sets the base URL', () {
        final command = ReviewSkipCommand(context: context);

        command.argParser.parse(['--api-url', 'https://api.example.com']);

        expect(
          command.cloudClient.client.options.baseUrl,
          equals('https://api.example.com/'),
        );
      });
    });
  });
}
