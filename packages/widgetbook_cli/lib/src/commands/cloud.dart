import 'dart:async';

import 'package:args/args.dart';

import '../core/core.dart';
import 'build_push.dart';
import 'project_create.dart';
import 'review_skip.dart';

class CloudCommand extends CliVoidCommand {
  CloudCommand({
    required super.context,
  }) : super(
         name: 'cloud',
         description: 'Manage your Widgetbook Cloud projects.',
       ) {
    addSubcommand(
      CliCommandsGroup(
        name: 'project',
        description: 'Manage the projects of your Widgetbook Cloud workspace.',
        commands: [
          ProjectCreateCommand(
            context: context,
          ),
        ],
      ),
    );

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
          ReviewSkipCommand(
            context: context,
          ),
        ],
      ),
    );
  }

  @override
  FutureOr<int> runWith(Context context, ArgResults args) => 0;
}
