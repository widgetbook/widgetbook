import 'dart:async';

import 'package:args/args.dart';

import '../core/core.dart';
import 'build_push.dart';

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
  }

  @override
  FutureOr<int> runWith(Context context, ArgResults args) => 0;
}
