import 'dart:js_interop';

import 'package:web/web.dart' as web;

Future<String> sendRequest(String method, Uri uri, String? body) async {
  final response = await web.window
      .fetch(
        uri.toString().toJS,
        web.RequestInit(
          method: method,
          headers: web.Headers()..append('content-type', 'application/json'),
          body: body?.toJS,
        ),
      )
      .toDart;

  final content = (await response.text().toDart).toDart;
  if (!response.ok) {
    throw Exception('${response.status} ${response.statusText}: $content');
  }

  return content;
}
