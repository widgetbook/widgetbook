import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pool/pool.dart';
import 'package:retry/retry.dart';

import 'storage_object.dart';

/// HTTP client to connect to the Widgetbook Cloud Storage
class StorageClient {
  StorageClient({
    Dio? client,
  }) : client = client ?? Dio();

  final Dio client;

  Future<void> uploadObjects(Iterable<StorageObject> objects) async {
    // The object count can reach up to 20K, posting all of them concurrently
    // can lead to going beyond the rate limit of the server. That's why we
    // limit the number of concurrent requests using a pool.
    final pool = Pool(
      1000,
      timeout: const Duration(
        seconds: 30,
      ),
    );

    final promises = objects.map((object) async {
      return retry(
        maxAttempts: 3,
        () => pool.withResource(
          () => _uploadObject(object),
        ),
      );
    });

    await Future.wait(
      promises,
      eagerError: true,
    );
  }

  Future<Response<void>> _uploadObject(StorageObject object) async {
    return client.put<void>(
      object.url,
      data: object.data,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: object.mimeType,
          HttpHeaders.contentLengthHeader: object.size,
        },
      ),
    );
  }
}
