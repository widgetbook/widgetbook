import 'dart:async';

import 'package:args/src/arg_results.dart';

import '../core/core.dart';
import 'build_push.dart';
import 'review_sync.dart';

class CloudCommand extends CliVoidCommand {
  CloudCommand({
    required super.context,
  }) : super(
          name: 'cloud',
          description: 'Manage your Widgetbook Cloud projects.',
        ) {
    addSubcommand(
      CliCommandsGroup(
        name: 'build',
        description: 'Manage your Widgetbook Cloud builds.',
        commands: [
          BuildPushCommand(
            context: context,
          ),
        ],
      ),
    );

    addSubcommand(
      CliCommandsGroup(
        name: 'review',
        description: 'Manage your Widgetbook Cloud reviews.',
        commands: [
          ReviewSyncCommand(
            context: context,
          ),
        ],
      ),
    );
  }

  @override
  FutureOr<int> runWith(Context context, ArgResults args) => 0;
}
