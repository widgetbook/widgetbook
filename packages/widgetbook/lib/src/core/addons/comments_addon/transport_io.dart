import 'dart:convert';
import 'dart:io';

Future<String> sendRequest(String method, Uri uri, String? body) async {
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 2);

  try {
    final request = await client.openUrl(method, uri);
    request.headers.contentType = ContentType.json;
    if (body != null) request.write(body);

    final response = await request.close();
    final content = await utf8.decodeStream(response);

    if (response.statusCode >= 400) {
      throw HttpException(content, uri: uri);
    }

    return content;
  } finally {
    client.close();
  }
}
