import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file/file.dart';
import 'package:mime/mime.dart';
import 'package:pool/pool.dart';
import 'package:retry/retry.dart';

/// HTTP client to connect to the Widgetbook Cloud Storage
class StorageClient {
  StorageClient({
    Dio? client,
  }) : client = client ?? Dio();

  final Dio client;

  Future<void> uploadFiles(
    Map<File, String> files,
  ) async {
    // The files count can reach up to 20K, posting all of them concurrently
    // can lead to going beyond the rate limit of the server. That's why we
    // limit the number of concurrent requests using a pool.
    final pool = Pool(
      1000,
      timeout: const Duration(
        seconds: 30,
      ),
    );

    final promises = files.entries.map((entry) async {
      return retry(
        maxAttempts: 3,
        () => pool.withResource(
          () => _uploadFile(entry.key, entry.value),
        ),
      );
    });

    await Future.wait(
      promises,
      eagerError: true,
    );
  }

  Future<Response<void>> _uploadFile(
    File file,
    String url,
  ) async {
    final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
    final fileSize = file.statSync().size;

    return client.put<void>(
      url,
      data: file.openRead(),
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: mimeType,
          HttpHeaders.contentLengthHeader: fileSize,
        },
      ),
    );
  }
}
