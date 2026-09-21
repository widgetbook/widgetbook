import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class RecordedRequest {
  const RecordedRequest({
    required this.method,
    required this.uri,
    required this.headers,
    required this.body,
  });

  final String method;
  final Uri uri;
  final Map<String, dynamic> headers;
  final Map<String, dynamic>? body;

  String? header(String name) {
    final key = headers.keys.firstWhere(
      (key) => key.toLowerCase() == name.toLowerCase(),
      orElse: () => '',
    );

    return headers[key] as String?;
  }
}

class FakeResponse {
  const FakeResponse(this.statusCode, this.body);

  final int statusCode;
  final Map<String, dynamic> body;
}

/// A Dio [HttpClientAdapter] that records every request as sent over the
/// wire and answers with the next of [responses], repeating the last one.
class FakeHttpAdapter implements HttpClientAdapter {
  FakeHttpAdapter(this.responses);

  final List<FakeResponse> responses;
  final requests = <RecordedRequest>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final bytes = requestStream == null
        ? <int>[]
        : await requestStream.expand((chunk) => chunk).toList();

    requests.add(
      RecordedRequest(
        method: options.method,
        uri: options.uri,
        headers: Map.of(options.headers),
        body: bytes.isEmpty
            ? null
            : jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>,
      ),
    );

    final response =
        responses[(requests.length - 1).clamp(0, responses.length - 1)];

    return ResponseBody.fromString(
      jsonEncode(response.body),
      response.statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
