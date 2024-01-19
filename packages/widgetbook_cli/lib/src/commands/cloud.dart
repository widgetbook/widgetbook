import 'package:args/command_runner.dart';

import '../core/core.dart';
import 'build_push.dart';
import 'review_sync.dart';

class CloudCommand extends Command<int> {
  CloudCommand({
    required Context context,
  }) {
    addSubcommand(
      BuildPushCommand(
        context: context,
      ),
    );

    addSubcommand(
      ReviewSyncCommand(
        context: context,
      ),
    );
  }

  @override
  final String name = 'cloud';

  @override
  final String description = 'Manage your Widgetbook Cloud projects.';

  @override
  Future<int> run() async => 0;
}
