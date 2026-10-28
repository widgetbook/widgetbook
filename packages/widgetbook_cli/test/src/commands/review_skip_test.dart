import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
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

    late Context context;
    late ArgResults results;
    late MockWidgetbookHttpClient client;
    late ReviewSkipCommand command;

    setUp(() {
      final logger = MockLogger();
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

      expect(args.apiKey, equals('key'));
      expect(args.prNumber, equals(123));
      expect(args.sha, equals(headSha));
      expect(args.reason, equals('No UI changes'));
    });

    test('throws when the pull request number is not a number', () {
      when(() => results['pr']).thenReturn('not-a-number');

      expect(
        () => command.parseResults(context, results),
        throwsA(isA<CliException>()),
      );
    });

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
          apiKey: 'key',
          prNumber: 123,
          sha: headSha,
          reason: 'No UI changes',
        ),
      );

      expect(exitCode, equals(ExitCode.success.code));
      verify(() => client.skipReview(123, any())).called(1);
    });

    group('api-url', () {
      test('is shown in the usage', () {
        final command = ReviewSkipCommand(context: context);

        expect(command.argParser.options['api-url']!.hide, isFalse);
        expect(command.argParser.usage, contains('--api-url'));
        expect(command.argParser.usage, contains('https://api.widgetbook.io/'));
      });

      for (final url in [
        'https://api.example.com',
        'https://api.example.com/',
      ]) {
        test('requests the API below $url', () async {
          final adapter = FakeHttpAdapter([
            const FakeResponse(200, {
              'sha': headSha,
              'state': 'success',
              'prNumber': 123,
            }),
          ]);
          final dio = Dio(BaseOptions(baseUrl: BASE_API_URL))
            ..httpClientAdapter = adapter;
          final logger = MockLogger();
          when(() => logger.progress(any())).thenReturn(MockProgress());
          final runner = CommandRunner<int>('test', 'test')
            ..addCommand(
              ReviewSkipCommand(
                context: context,
                logger: logger,
                cloudClient: WidgetbookHttpClient(client: dio),
              ),
            );

          final exitCode = await runner.run([
            'skip',
            ...['--api-key', 'key', '--pr', '123', '--sha', headSha],
            ...['--api-url', url],
          ]);

          expect(exitCode, equals(ExitCode.success.code));
          expect(
            adapter.requests.single.uri,
            equals(
              Uri.parse(
                'https://api.example.com/v4/pull-requests/123/review-skip',
              ),
            ),
          );
        });
      }

      for (final url in [
        'api.widgetbook.io',
        'ftp://x',
        'https://',
        'https://host/?x',
      ]) {
        test('rejects $url as a usage error', () async {
          final logger = MockLogger();
          final runner = CliRunner(
            context: context,
            logger: logger,
            pubUpdater: MockPubUpdater(),
          );

          final exitCode = await runner.run([
            'cloud',
            'review',
            'skip',
            ...['--api-key', 'key', '--pr', '123', '--sha', headSha],
            ...['--api-url', url],
          ]);

          expect(exitCode, equals(ExitCode.usage.code));
          verify(
            () => logger.err(
              'The --api-url option must be an http or https URL, '
              'got "$url".',
            ),
          ).called(1);
        });
      }
    });
  });
}
