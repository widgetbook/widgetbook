import 'dart:async';

import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';

import '../api/api.dart';
import '../core/core.dart';
import 'cloud_options.dart';
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
      ..addApiKeyOption()
      ..addProjectOption()
      ..addOption(
        'pr',
        help: 'Pull request number (e.g. 123)',
        mandatory: true,
      )
      ..addOption(
        'sha',
        help:
            'Head commit SHA of the pull request. Must be the head commit, '
            'not the merge commit your CI checks out by default.',
        mandatory: true,
      )
      ..addOption(
        'reason',
        help: 'Shown in the commit status (e.g. "No UI changes")',
      )
      ..addApiUrlOption(this.cloudClient);
  }

  final WidgetbookHttpClient cloudClient;

  @override
  FutureOr<ReviewSkipArgs> parseResults(
    Context context,
    ArgResults results,
  ) {
    final prOption = results['pr'] as String;
    final prNumber = int.tryParse(prOption);

    if (prNumber == null) {
      throw CliException(
        'The option pr must be a number, got "$prOption".',
        ExitCode.data.code,
      );
    }

    return ReviewSkipArgs(
      apiKey: results['api-key'] as String,
      project: parseProjectOption(results),
      prNumber: prNumber,
      sha: results['sha'] as String,
      reason: results['reason'] as String?,
    );
  }

  @override
  FutureOr<int> runWith(Context context, ReviewSkipArgs args) async {
    final progress = logger.progress(
      'Skipping Widgetbook review for PR #${args.prNumber}',
    );

    try {
      final project = await cloudClient.resolveProject(
        args.apiKey,
        name: args.project,
      );

      final response = await cloudClient.skipReview(
        args.apiKey,
        project,
        args.prNumber,
        SkipReviewRequest(
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
