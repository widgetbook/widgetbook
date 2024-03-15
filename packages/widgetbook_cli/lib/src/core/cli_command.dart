import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

import 'cli_runner.dart';
import 'context.dart';

/// A [Context]-aware [Command] for [CliRunner].
abstract class CliCommand<TArgs> extends Command<int> {
  CliCommand({
    required this.context,
    required this.name,
    required this.description,
    Logger? logger,
  }) : logger = logger ?? Logger();

  final Logger logger;
  final Context context;

  @override
  final String name;

  @override
  final String description;

  /// Parses the [results] into [TArgs] using [context].
  FutureOr<TArgs> parseResults(Context context, ArgResults results);

  /// Runs this command with [context] from and parsed [args].
  FutureOr<int> runWith(Context context, TArgs args);

  @override
  FutureOr<int>? run() async {
    try {
      final results = argResults!;
      final args = await parseResults(context, results);

      return runWith(context, args);
    } catch (e, stackTrace) {
      logger.err('Something wrong happened');
      logger.err(e.toString());
      logger.err(stackTrace.toString());

      return -1;
    }
  }
}

/// [CliCommand] that does not [parseResults].
abstract class CliVoidCommand extends CliCommand<ArgResults> {
  CliVoidCommand({
    required super.context,
    required super.name,
    required super.description,
    super.logger,
  });

  @override
  FutureOr<ArgResults> parseResults(Context context, ArgResults results) {
    return results;
  }
}
