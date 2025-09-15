import 'package:mason_logger/mason_logger.dart';

class CliException implements Exception {
  CliException(this.message, this.exitCode);

  final String message;
  final int exitCode;

  @override
  String toString() => message;
}

class MissingOptionException extends CliException {
  MissingOptionException(this.option)
    : super(
        'The option $option is required but was neither '
        'provided nor resolved from the default values.',
        ExitCode.data.code,
      );

  final String option;
}
