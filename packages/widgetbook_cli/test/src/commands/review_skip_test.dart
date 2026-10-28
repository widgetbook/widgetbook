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
  });
}
