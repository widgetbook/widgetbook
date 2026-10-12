import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/api/cloud_exception.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/fake_http_adapter.dart';
import '../../helper/mocks.dart';

class _FakeSkipReviewRequest extends Fake implements SkipReviewRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeSkipReviewRequest());
  });

  group('$ReviewSkipCommand', () {
    const headSha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';
    const workspaceKey = WorkspaceApiKey('widgetbook_ws_secret');

    late Logger logger;
    late Context context;
    late ArgResults results;
    late MockWidgetbookHttpClient client;
    late ReviewSkipCommand command;

    setUp(() {
      logger = MockLogger();
      when(() => logger.progress(any<String>())).thenReturn(MockProgress());

      context = MockContext();
      results = MockArgResults();
      client = MockWidgetbookHttpClient();
      command = ReviewSkipCommand(
        context: context,
        logger: logger,
        cloudClient: client,
      );

      when(() => results['api-key']).thenReturn('key');
      when(() => results['pr']).thenReturn('123');
      when(() => results['sha']).thenReturn(headSha);
      when(() => results['reason']).thenReturn('No UI changes');
    });

    test('parses the passed options', () async {
      final args = await command.parseResults(context, results);

      expect(
        args.apiKey,
        isA<ProjectApiKey>().having((key) => key.value, 'value', 'key'),
      );
      expect(args.project, isNull);
      expect(args.prNumber, equals(123));
      expect(args.sha, equals(headSha));
      expect(args.reason, equals('No UI changes'));
    });

    test('parses a workspace key with its project', () async {
      when(() => results['api-key']).thenReturn('widgetbook_ws_secret');
      when(() => results['project']).thenReturn('my-app');

      final args = await command.parseResults(context, results);

      expect(
        args.apiKey,
        isA<WorkspaceApiKey>().having(
          (key) => key.value,
          'value',
          'widgetbook_ws_secret',
        ),
      );
      expect(args.project, equals('my-app'));
    });

    test('throws when the pull request number is not a number', () {
      when(() => results['pr']).thenReturn('not-a-number');

      expect(
        () => command.parseResults(context, results),
        throwsA(isA<CliException>()),
      );
    });

    test(
      'fails before any request for a workspace key without project',
      () async {
        final runner = CommandRunner<int>('widgetbook', 'CLI')
          ..addCommand(command);

        await expectLater(
          runner.run([
            'skip',
            '--api-key',
            'widgetbook_ws_secret',
            '--pr',
            '123',
            '--sha',
            headSha,
          ]),
          throwsA(
            isA<CliException>().having(
              (e) => e.message,
              'message',
              equals('A workspace API key needs --project <name>.'),
            ),
          ),
        );

        verifyZeroInteractions(client);
      },
    );

    test('posts the skip and reports the resulting status', () async {
      when(() => client.skipReview(any(), any())).thenAnswer(
        (_) async => const SkipReviewResponse(
          sha: headSha,
          state: 'success',
          prNumber: 123,
        ),
      );

      final exitCode = await command.runWith(
        context,
        const ReviewSkipArgs(
          apiKey: ProjectApiKey('key'),
          project: null,
          prNumber: 123,
          sha: headSha,
          reason: 'No UI changes',
        ),
      );

      expect(exitCode, equals(ExitCode.success.code));

      final request =
          verify(() => client.skipReview(123, captureAny())).captured.single
              as SkipReviewRequest;
      expect(request.projectName, isNull);
    });

    test('names the project of a workspace key', () async {
      when(() => client.skipReview(any(), any())).thenAnswer(
        (_) async => const SkipReviewResponse(
          sha: headSha,
          state: 'success',
          prNumber: 123,
        ),
      );

      await command.runWith(
        context,
        const ReviewSkipArgs(
          apiKey: workspaceKey,
          project: 'my-app',
          prNumber: 123,
          sha: headSha,
          reason: null,
        ),
      );

      final request =
          verify(() => client.skipReview(123, captureAny())).captured.single
              as SkipReviewRequest;
      expect(request.apiKey, same(workspaceKey));
      expect(request.projectName, equals('my-app'));
    });

    test('points to project create when the project is unknown', () async {
      when(() => client.skipReview(any(), any())).thenThrow(
        CloudException(
          "No project named 'my-app' in this workspace.",
          statusCode: 422,
        ),
      );

      await expectLater(
        command.runWith(
          context,
          const ReviewSkipArgs(
            apiKey: workspaceKey,
            project: 'my-app',
            prNumber: 123,
            sha: headSha,
            reason: null,
          ),
        ),
        throwsA(
          isA<CliException>().having(
            (e) => e.message,
            'message',
            equals(
              "No project named 'my-app'. "
              'Create it with: '
              'widgetbook cloud project create --project my-app',
            ),
          ),
        ),
      );
    });

    test('passes other 422 errors through without retrying', () async {
      const detail = "This API key does not belong to project 'my-app'.";
      final adapter = FakeHttpAdapter([
        const FakeResponse(422, {'message': detail}),
      ]);
      final command = ReviewSkipCommand(
        context: context,
        logger: logger,
        cloudClient: WidgetbookHttpClient()..client.httpClientAdapter = adapter,
      );

      await expectLater(
        command.runWith(
          context,
          const ReviewSkipArgs(
            apiKey: ProjectApiKey('key'),
            project: 'my-app',
            prNumber: 123,
            sha: headSha,
            reason: null,
          ),
        ),
        throwsA(
          isA<CloudException>()
              .having((e) => e.statusCode, 'statusCode', 422)
              .having((e) => e.message, 'message', contains(detail)),
        ),
      );

      expect(adapter.requests, hasLength(1));
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
