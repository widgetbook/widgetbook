import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'comment.dart';
import 'comment_store.dart';

/// The HTTP API that the Widgetbook UI uses to read and write comments.
///
/// It only listens on the loopback interface and sends no CORS headers,
/// so browsers cannot reach it from other origins.
class CommentsHttpServer {
  CommentsHttpServer(this.store);

  final CommentStore store;
  HttpServer? _server;

  int? get port => _server?.port;

  Future<void> start({int port = defaultPort}) async {
    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
    _server!.listen(_handle);
  }

  Future<void> close() async => _server?.close(force: true);

  static const defaultPort = 7357;

  Future<void> _handle(HttpRequest request) async {
    final response = request.response;

    try {
      final result = await _route(request);
      response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.json
        ..write(jsonEncode(result));
    } on CommentNotFoundException catch (error) {
      _error(response, HttpStatus.notFound, error.toString());
    } on CommentTransitionException catch (error) {
      _error(response, HttpStatus.conflict, error.toString());
    } on _RouteNotFound {
      _error(response, HttpStatus.notFound, 'Not found');
    } on FormatException catch (error) {
      _error(response, HttpStatus.badRequest, error.message);
    } on TypeError catch (error) {
      _error(response, HttpStatus.badRequest, error.toString());
    }

    await response.close();
  }

  Future<Object?> _route(HttpRequest request) async {
    final segments = request.uri.pathSegments;
    final method = request.method;

    switch ((method, segments)) {
      case ('GET', ['info']):
        return {'root': store.root};

      case ('GET', ['comments']):
        final storyPath = request.uri.queryParameters['story'];
        return {
          'comments': store
              .list(storyPath: storyPath)
              .map((comment) => comment.toJson())
              .toList(),
        };

      case ('POST', ['comments']):
        final body = await _body(request);
        final screenshot = body['screenshot'] as String?;
        return store
            .create(
              storyPath: body['storyPath'] as String,
              storyUrl: body['storyUrl'] as String?,
              text: body['text'] as String,
              anchor:
                  (body['anchor'] as Map?)?.cast<String, dynamic>() ?? const {},
              screenshotPng: screenshot == null
                  ? null
                  : base64Decode(screenshot),
            )
            .toJson();

      case ('POST', ['comments', final id, 'messages']):
        final body = await _body(request);
        return store
            .reply(id, CommentAuthor.user, body['text'] as String)
            .toJson();

      case ('PATCH', ['comments', final id]):
        final body = await _body(request);
        return store
            .setStatus(
              id,
              CommentAuthor.user,
              CommentStatus.parse(body['status'] as String),
            )
            .toJson();

      case ('DELETE', ['comments', final id]):
        store.delete(id);
        return {'id': id};

      case ('POST', ['reviews']):
        final body = await _body(request);
        final submitted = store.submit(
          storyPath: body['storyPath'] as String?,
        );
        return {
          'comments': submitted.map((comment) => comment.toJson()).toList(),
        };
    }

    throw _RouteNotFound();
  }

  Future<Map<String, dynamic>> _body(HttpRequest request) async {
    final content = await utf8.decodeStream(request);
    if (content.isEmpty) return {};

    final json = jsonDecode(content);
    if (json is! Map) throw const FormatException('Expected a JSON object');
    return json.cast<String, dynamic>();
  }

  void _error(HttpResponse response, int statusCode, String message) {
    response
      ..statusCode = statusCode
      ..headers.contentType = ContentType.json
      ..write(jsonEncode({'error': message}));
  }
}

class _RouteNotFound implements Exception {}
