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
    const mergeSha = '0000000111112222233333444445555566666777';

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
      when(() => results['pr']).thenReturn(null);
      when(() => results['sha']).thenReturn(null);
      when(() => results['reason']).thenReturn(null);

      when(() => context.providerPrNumber).thenReturn(null);
      when(() => context.providerPrHeadSha).thenReturn(null);
      when(() => context.providerSha).thenReturn(null);
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

      test('falls back to the pull request detected from CI', () async {
        when(() => context.providerPrNumber).thenReturn(456);
        when(() => context.providerPrHeadSha).thenReturn(headSha);

        final args = await command.parseResults(context, results);

        expect(args.prNumber, equals(456));
        expect(args.sha, equals(headSha));
      });

      test('never falls back to the merge commit', () async {
        // On a pull request event `providerSha` is the merge commit, which
        // Widgetbook does not track as the head. Defaulting to it would make
        // every skip fail as a stale SHA.
        when(() => context.providerPrNumber).thenReturn(456);
        when(() => context.providerSha).thenReturn(mergeSha);

        expect(
          () => command.parseResults(context, results),
          throwsA(isA<MissingOptionException>()),
        );
      });

      test('throws when no pull request can be resolved', () async {
        when(() => results['sha']).thenReturn(headSha);

        expect(
          () => command.parseResults(context, results),
          throwsA(isA<MissingOptionException>()),
        );
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
