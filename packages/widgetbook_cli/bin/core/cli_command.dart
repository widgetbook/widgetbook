import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

import 'cli_runner.dart';
import 'context.dart';

/// A [Context]-aware [Command] for [CliRunner].
abstract class CliCommand<TArgs> extends Command<int> {
  CliCommand({
    required Context context,
    required this.name,
    required this.description,
    Logger? logger,
  })  : _globalContext = context,
        logger = logger ?? Logger();

  final Logger logger;

  /// The global [Context]
  final Context _globalContext;

  @override
  final String name;

  @override
  final String description;

  /// Overrides global [context] with a new local [Context] using [results],
  /// that is used for [runWith].
  FutureOr<Context> overrideContext(
    Context context,
    ArgResults results,
  ) {
    // Global context is used by default.
    return _globalContext;
  }

  /// Parses the [results] into [TArgs] using [context].
  FutureOr<TArgs> parseResults(Context context, ArgResults results);

  /// Runs the command with the local [context] from [overrideContext]
  /// and parsed [args] from [parseResults].
  FutureOr<int> runWith(Context context, TArgs args);

  @override
  FutureOr<int>? run() async {
    final results = argResults!;
    final localContext = await overrideContext(_globalContext, results);
    final args = await parseResults(_globalContext, results);

    return runWith(localContext, args);
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
