import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pool/pool.dart';
import 'package:retry/retry.dart';

import 'storage_exception.dart';
import 'storage_object.dart';

/// HTTP client to connect to the Widgetbook Cloud Storage
class StorageClient {
  StorageClient({
    Dio? client,
  }) : client = client ?? Dio();

  final Dio client;

  Future<void> uploadObjects(
    String url,
    Map<String, String> fields,
    Iterable<StorageObject> objects,
  ) async {
    // The object count can reach up to 20K, posting all of them concurrently
    // can lead to going beyond the rate limit of the server. That's why we
    // limit the number of concurrent requests using a pool.
    final pool = Pool(
      500,
      timeout: const Duration(
        seconds: 30,
      ),
    );

    final promises = objects.map((object) async {
      return retry(
        maxAttempts: 3,
        () => pool.withResource(
          () => _uploadObject(url, fields, object),
        ),
      );
    });

    await Future.wait(
      promises,
      eagerError: true,
    );
  }

  Future<Response<void>> _uploadObject(
    String url,
    Map<String, String> fields,
    StorageObject object,
  ) async {
    final baseKey = fields['key']!;
    final fileKey = baseKey.replaceAll(
      r'${filename}',
      object.key,
    );

    return client
        .post<void>(
          url,
          data: FormData.fromMap(
            {
              ...fields,
              'key': fileKey,
              'Content-Type': object.mimeType,
              'file': MultipartFile.fromStream(
                () => object.reader(),
                object.size,
                filename: fileKey,
                contentType: DioMediaType.parse(object.mimeType),
              ),
            },
          ),
        )
        .onError(
          (error, stackTrace) => throw StorageUploadException.parse(
            object,
            error!,
          ),
        );
  }
}
