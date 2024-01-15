import 'package:args/command_runner.dart';

import '../core/core.dart';
import 'push.dart';

class CloudCommand extends Command<int> {
  CloudCommand({
    required Context context,
  }) {
    addSubcommand(
      PushCommand(
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
