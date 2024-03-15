import 'dart:async';

import 'package:args/command_runner.dart';

class CliCommandsGroup extends Command<int> {
  CliCommandsGroup({
    required this.name,
    required this.description,
    required List<Command<int>> commands,
  }) {
    commands.forEach(addSubcommand);
  }

  @override
  final String name;

  @override
  final String description;

  @override
  FutureOr<int> run() => 0;
}
