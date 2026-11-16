import 'dart:convert';

import 'package:meta/meta.dart';

import 'comment.dart';
import 'transport_stub.dart' if (dart.library.io) 'transport_io.dart';

/// Talks to the local HTTP API of `widgetbook mcp`.
@internal
class CommentsClient {
  CommentsClient({required this.port});

  final int port;

  Uri _uri(String path, [Map<String, String>? query]) {
    return Uri(
      scheme: 'http',
      host: '127.0.0.1',
      port: port,
      path: path,
      queryParameters: query,
    );
  }

  Future<Map<String, dynamic>> _send(
    String method,
    String path, {
    Map<String, String>? query,
    Map<String, Object?>? body,
  }) async {
    final response = await sendRequest(
      method,
      _uri(path, query),
      body == null ? null : jsonEncode(body),
    );
    return (jsonDecode(response) as Map).cast<String, dynamic>();
  }

  /// The project directory that the server stores comments in.
  Future<String> root() async {
    final info = await _send('GET', '/info');
    return info['root'] as String;
  }

  Future<List<StoryComment>> list(String storyPath) async {
    final json = await _send('GET', '/comments', query: {'story': storyPath});
    return (json['comments'] as List)
        .cast<Map<String, dynamic>>()
        .map(StoryComment.fromJson)
        .toList();
  }

  Future<void> create({
    required String storyPath,
    required String storyUrl,
    required String text,
    required CommentAnchor anchor,
    List<int>? screenshot,
  }) async {
    await _send(
      'POST',
      '/comments',
      body: {
        'storyPath': storyPath,
        'storyUrl': storyUrl,
        'text': text,
        'anchor': anchor.toJson(),
        if (screenshot != null) 'screenshot': base64Encode(screenshot),
      },
    );
  }

  Future<void> reply(String id, String text) async {
    await _send('POST', '/comments/$id/messages', body: {'text': text});
  }

  Future<void> setStatus(String id, CommentStatus status) async {
    await _send('PATCH', '/comments/$id', body: {'status': status.name});
  }

  Future<void> delete(String id) async {
    await _send('DELETE', '/comments/$id');
  }

  /// Submits the drafts of [storyPath] as one review.
  Future<void> submit(String storyPath) async {
    await _send('POST', '/reviews', body: {'storyPath': storyPath});
  }
}
