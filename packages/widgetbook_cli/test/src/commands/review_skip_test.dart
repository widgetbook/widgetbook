import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';

class _FakeSkipReviewRequest extends Fake implements SkipReviewRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeSkipReviewRequest());
  });

  group('$ReviewSkipCommand', () {
    const headSha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';

    late Logger logger;
    late Progress progress;
    late Context context;
    late ArgResults results;
    late ReviewSkipCommand command;

    setUp(() {
      logger = MockLogger();
      progress = MockProgress();
      context = MockContext();
      results = MockArgResults();

      when(() => logger.progress(any<String>())).thenReturn(progress);

      command = ReviewSkipCommand(context: context, logger: logger);

      when(() => results['api-key']).thenReturn('key');
      when(() => results['pr']).thenReturn('123');
      when(() => results['sha']).thenReturn(headSha);
      when(() => results['reason']).thenReturn(null);
    });

    group('parseResults', () {
      test('uses explicitly passed options', () async {
        when(() => results['pr']).thenReturn('123');
        when(() => results['sha']).thenReturn(headSha);
        when(() => results['reason']).thenReturn('No UI changes');

        final args = await command.parseResults(context, results);

        expect(args.apiKey, equals('key'));
        expect(args.prNumber, equals(123));
        expect(args.sha, equals(headSha));
        expect(args.reason, equals('No UI changes'));
      });

      test('throws when the pull request number is not a number', () async {
        when(() => results['pr']).thenReturn('not-a-number');
        when(() => results['sha']).thenReturn(headSha);

        expect(
          () => command.parseResults(context, results),
          throwsA(isA<CliException>()),
        );
      });
    });

    group('runWith', () {
      test('posts the skip and reports the resulting status', () async {
        final client = MockWidgetbookHttpClient();
        final command = ReviewSkipCommand(
          context: context,
          logger: logger,
          cloudClient: client,
        );

        when(
          () => client.skipReview(any(), any()),
        ).thenAnswer(
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
    });
  });
}
