import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:meta/meta.dart';

abstract class WidgetbookCommand extends Command<int> {
  WidgetbookCommand({Logger? logger}) : _logger = logger ?? Logger();

  /// [Logger] instance used to wrap stdout.
  Logger get logger => _logger;

  final Logger _logger;

  /// [ArgResults] used for testing purposes only.
  @visibleForTesting
  ArgResults? testArgResults;

  /// [ArgResults] for the current command.
  ArgResults get results => testArgResults ?? argResults!;
}
