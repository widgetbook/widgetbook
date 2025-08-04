import 'package:dio/dio.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:xml/xml.dart';

import '../core/core.dart';
import 'storage_object.dart';

class StorageUploadException extends CliException {
  StorageUploadException(String filePath, String message)
    : super(
        'Something went wrong while uploading [$filePath] to Widgetbook Cloud storage:\n'
        '$message\n',
        ExitCode.software.code,
      );

  static StorageUploadException parse(StorageObject object, Object exception) {
    if (exception is! DioException) {
      return StorageUploadException(
        object.key,
        '$exception',
      );
    }

    final body = exception.response?.data;

    if (body != null && body is String) {
      try {
        // Storage server returns XML error messages
        final document = XmlDocument.parse(body);

        return StorageUploadException(
          object.key,
          document.toXmlString(pretty: true, indent: '  '),
        );
      } on XmlParserException {
        // If the response is not XML, just return the body as is
        // to avoid throwing xml parsing exceptions
        return StorageUploadException(
          object.key,
          body,
        );
      }
    }

    return StorageUploadException(
      object.key,
      '${exception.message}',
    );
  }
}
