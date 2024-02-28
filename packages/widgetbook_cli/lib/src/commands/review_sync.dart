import 'dart:async';

import 'package:args/src/arg_results.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:process/process.dart';

import '../../widgetbook_cli.dart';
import 'review_sync_args.dart';

class ReviewSyncCommand extends CliCommand<ReviewSyncArgs> {
  ReviewSyncCommand({
    required super.context,
    this.processManager = const LocalProcessManager(),
    this.fileSystem = const LocalFileSystem(),
  })  : client = WidgetbookHttpClient(
          environment: context.environment,
        ),
        super(
          name: 'sync',
          description: 'Syncs Widgetbook Cloud Review',
        ) {
    argParser
      ..addOption(
        'api-key',
        help: 'The project specific API key for Widgetbook Cloud.',
        mandatory: true,
      )
      ..addOption(
        'head-branch',
        help: 'The head branch of the pull-request. For example, feat/foo.',
      )
      ..addOption(
        'base-branch',
        help: 'The base branch of the pull-request. For example, main.',
        mandatory: true,
      )
      ..addOption(
        'head-sha',
        help: 'The sha of head commit of the pull-request.',
      )
      ..addOption(
        'base-sha',
        help: 'The sha of base commit of the pull-request.',
      );
  }

  final WidgetbookHttpClient client;
  final ProcessManager processManager;
  final FileSystem fileSystem;

  @override
  FutureOr<ReviewSyncArgs> parseResults(
    Context context,
    ArgResults results,
  ) async {
    final apiKey = results['api-key'] as String;
    final repository = context.repository!;
    final currentBranch = await repository.currentBranch;
    final headBranch = results['head-branch'] as String? ?? currentBranch.name;
    final headSha = results['head-sha'] as String? ??
        context.providerSha ??
        currentBranch.sha;

    final baseBranch = results['base-branch'] as String;
    final baseSha = results['base-sha'] as String? ??
        (await repository.findBranch(
          baseBranch,
          remote: true,
        ))
            ?.sha;

    return ReviewSyncArgs(
      apiKey: apiKey,
      headBranch: headBranch,
      baseBranch: baseBranch,
      headSha: headSha,
      baseSha: baseSha!,
    );
  }

  @override
  FutureOr<int> runWith(Context context, ReviewSyncArgs args) async {
    final syncProgress = logger.progress('Syncing review');
    final response = await client.syncReview(
      ReviewSyncRequest(
        apiKey: args.apiKey,
        baseBranch: args.baseBranch,
        headBranch: args.headBranch,
        baseSha: args.baseSha,
        headSha: args.headSha,
      ),
    );

    syncProgress.complete('Review [${response.reviewId}] synced');

    return 0;
  }
}
