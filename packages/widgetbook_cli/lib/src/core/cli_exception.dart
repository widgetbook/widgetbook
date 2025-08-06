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

class FolderNotFoundException implements CliException {
  FolderNotFoundException({String? message})
    : _message = message ??= 'Folder does not exist.';

  final String? _message;

  @override
  String get message => _message!;

  @override
  int get exitCode => -1;
}

class InvalidInputException implements CliException {
  InvalidInputException({String? message})
    : _message = message ??= 'Invalid user input.';

  final String? _message;

  @override
  String get message => _message!;

  @override
  int get exitCode => -1;
}

class InvalidFlutterPackageException implements CliException {
  InvalidFlutterPackageException({String? message})
    : _message = message ??= 'Invalid Flutter package.';

  final String? _message;

  @override
  String get message => _message!;

  @override
  int get exitCode => -1;
}

class InvalidWidgetbookPackageException implements CliException {
  InvalidWidgetbookPackageException({String? message})
    : _message = message ??= 'Invalid Widgetbook package.';

  final String? _message;

  @override
  String get message => _message!;

  @override
  int get exitCode => -1;
}

class FileNotFoundException implements CliException {
  FileNotFoundException({String? message})
    : _message = message ??= 'File does not exist.';

  final String? _message;

  @override
  String get message => _message!;

  @override
  int get exitCode => -1;
}
