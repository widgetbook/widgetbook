import 'dart:convert';

import 'package:mason_logger/mason_logger.dart';

import '../core/core.dart';

String prettifyJson(Map<String, dynamic> json) {
  return const JsonEncoder.withIndent('  ').convert(json);
}

class CacheFormatException extends CliException {
  CacheFormatException(
    String name,
    Map<String, dynamic> json,
    Object originalError,
  ) : super(
        'Failed to parse $name cache:\n'
        '${prettifyJson(json)}\n\n'
        'Reason: $originalError',
        ExitCode.data.code,
      );
}
