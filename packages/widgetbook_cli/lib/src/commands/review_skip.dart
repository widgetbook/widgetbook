import 'dart:async';

import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';

import '../api/api.dart';
import '../core/core.dart';
import 'review_skip_args.dart';

class ReviewSkipCommand extends CliCommand<ReviewSkipArgs> {
  ReviewSkipCommand({
    required super.context,
    super.logger,
    WidgetbookHttpClient? cloudClient,
  }) : cloudClient = cloudClient ?? WidgetbookHttpClient(),
       super(
         name: 'skip',
         description:
             'Marks the Widgetbook Review check of a pull request as passing, '
             'for a commit that uploads no build.',
       ) {
    argParser
      ..addOption(
        'api-key',
        help: "Project's API key from setting page on Widgetbook Cloud",
        mandatory: true,
      )
      ..addOption(
        'pr',
        help: 'Pull request number (e.g. 123)',
      )
      ..addOption(
        'sha',
        help:
            'Head commit SHA of the pull request. Must be the head commit, '
            'not the merge commit your CI checks out by default.',
      )
      ..addOption(
        'reason',
        help: 'Shown in the commit status (e.g. "No UI changes")',
      )
      ..addOption(
        'api-url',
        hide: true,
        callback: (url) {
          if (url == null) return;
          this.cloudClient.client.options.baseUrl = url;
        },
      );
  }

  final WidgetbookHttpClient cloudClient;

  @override
  FutureOr<ReviewSkipArgs> parseResults(
    Context context,
    ArgResults results,
  ) {
    final apiKey = results['api-key'] as String;

    final prOption = results['pr'] as String?;
    final prNumber = prOption != null
        ? int.tryParse(prOption)
        : context.providerPrNumber;

    if (prOption != null && prNumber == null) {
      throw CliException(
        'The option pr must be a number, got "$prOption".',
        ExitCode.data.code,
      );
    }

    if (prNumber == null) {
      throw MissingOptionException('pr');
    }

    // Never falls back to `context.providerSha`: on a pull request event that
    // is the merge commit, which Widgetbook does not track as the head, so
    // every skip would be rejected as stale.
    final sha = results['sha'] as String? ?? context.providerPrHeadSha;

    if (sha == null) {
      throw MissingOptionException('sha');
    }

    return ReviewSkipArgs(
      apiKey: apiKey,
      prNumber: prNumber,
      sha: sha,
      reason: results['reason'] as String?,
    );
  }

  @override
  FutureOr<int> runWith(Context context, ReviewSkipArgs args) async {
    final progress = logger.progress(
      'Skipping Widgetbook review for PR #${args.prNumber}',
    );

    try {
      final response = await cloudClient.skipReview(
        args.prNumber,
        SkipReviewRequest(
          apiKey: args.apiKey,
          sha: args.sha,
          reason: args.reason,
        ),
      );

      progress.complete(
        'Skipped Widgetbook review for PR #${response.prNumber} '
        'on ${response.sha.substring(0, 7)}',
      );

      return ExitCode.success.code;
    } catch (e) {
      progress.fail('Could not skip the Widgetbook review');
      rethrow;
    }
  }
}
