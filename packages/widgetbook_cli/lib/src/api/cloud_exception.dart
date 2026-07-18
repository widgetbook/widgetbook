import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:mason_logger/mason_logger.dart';

import '../core/core.dart';

class CloudException extends CliException {
  CloudException(String message, {this.statusCode})
    : super(
        'Something went wrong while communicating with the Widgetbook Cloud:\n'
        '$message\n',
        ExitCode.software.code,
      );

  /// HTTP status code of the failed response, or `null` when the server did
  /// not respond (e.g. timeout, connection or handshake errors).
  final int? statusCode;

  static CloudException parse(Object exception, StackTrace stackTrace) {
    if (exception is! DioException) {
      return CloudException('$exception\n$stackTrace');
    }

    final response = exception.response;

    // If the server has not responded, use the dio message. This can be
    // in case in of errors like timeout, connection, handshake, etc.
    if (response == null) {
      return CloudException(
        exception.message ?? '$exception',
      );
    }

    final statusCode = response.statusCode;
    final body = response.data;

    // If the body is JSON, then the server has responded,
    // and we can parse that response to customize the error message.
    if (body is Map<String, dynamic>) {
      final message = body['message'];

      // If body has "message", in case of validation error
      // or other 4xx errors, use this message instead of the default message.
      if (message is List<dynamic>) {
        // Validation error' message is as a list of strings
        // (e.g. ['Field is required', 'Field must be unique']).
        return CloudException(
          message.mapIndexed((i, msg) => '${i + 1}. $msg').join('\n'),
          statusCode: statusCode,
        );
      } else if (message is String) {
        // Other 4xx errors' message is as a single string.
        // (e.g. 'Could not find API key').
        return CloudException(message, statusCode: statusCode);
      } else {
        // Message is non-string, use the full body instead.
        return CloudException('$body', statusCode: statusCode);
      }
    }

    // Body can be HTML or string at this point.
    return CloudException(
      '${exception.message}\n${body ?? ''}',
      statusCode: statusCode,
    );
  }
}
