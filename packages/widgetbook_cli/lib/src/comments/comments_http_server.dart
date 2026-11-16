import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'comment.dart';
import 'comment_store.dart';

/// The HTTP API that the Widgetbook UI uses to read and write comments.
///
/// It only listens on the loopback interface and only answers requests
/// addressed to a loopback host, which rules out DNS rebinding. Browsers may
/// only reach it from loopback origins, i.e. a Widgetbook served by
/// `flutter run`; requests from any other website are rejected.
class CommentsHttpServer {
  CommentsHttpServer(
    this.store, {
    this.maxBodyBytes = 20 * 1024 * 1024,
  });

  final CommentStore store;

  /// The largest accepted request body, which mostly consists of the
  /// base64 encoded screenshot.
  final int maxBodyBytes;

  HttpServer? _server;

  int? get port => _server?.port;

  bool get isRunning => _server != null;

  Future<void> start({int port = defaultPort}) async {
    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
    _server!.listen((request) => unawaited(_handle(request)));
  }

  Future<void> close() async => _server?.close(force: true);

  static const defaultPort = 7357;

  static const _loopbackHosts = {'localhost', '127.0.0.1', '::1', '[::1]'};

  static bool isLoopbackOrigin(String origin) {
    final uri = Uri.tryParse(origin);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        _loopbackHosts.contains(uri.host);
  }

  bool _isLoopbackHost(HttpHeaders headers) {
    final host = headers.host;
    return host != null &&
        _loopbackHosts.contains(host) &&
        (headers.port == null || headers.port == port);
  }

  Future<void> _handle(HttpRequest request) async {
    final response = request.response;

    try {
      await _respond(request, response);
    } catch (error) {
      _reportUnexpected(response, error);
    }

    await _closeQuietly(response);
  }

  void _reportUnexpected(HttpResponse response, Object error) {
    try {
      _error(response, HttpStatus.internalServerError, '$error');
    } on StateError {
      return;
    }
  }

  Future<void> _closeQuietly(HttpResponse response) async {
    try {
      await response.close();
    } on Exception {
      return;
    }
  }

  Future<void> _respond(HttpRequest request, HttpResponse response) async {
    if (!_isLoopbackHost(request.headers)) {
      return _error(response, HttpStatus.forbidden, 'Host is not allowed');
    }

    final origin = request.headers.value('origin');
    if (origin != null) {
      if (!isLoopbackOrigin(origin)) {
        return _error(
          response,
          HttpStatus.forbidden,
          'Origin $origin is not allowed',
        );
      }

      response.headers
        ..set('access-control-allow-origin', origin)
        ..set('vary', 'origin');
    }

    if (request.method == 'OPTIONS') {
      response
        ..statusCode = HttpStatus.noContent
        ..headers.set(
          'access-control-allow-methods',
          'GET, POST, PATCH, DELETE',
        )
        ..headers.set('access-control-allow-headers', 'content-type')
        ..headers.set('access-control-allow-private-network', 'true');
      return;
    }

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
    } on CommentOutsideProjectException catch (error) {
      _error(response, HttpStatus.conflict, error.toString());
    } on _RouteNotFound {
      _error(response, HttpStatus.notFound, 'Not found');
    } on _BodyTooLarge {
      _error(
        response,
        HttpStatus.requestEntityTooLarge,
        'The request is larger than $maxBodyBytes bytes',
      );
    } on FormatException catch (error) {
      _error(response, HttpStatus.badRequest, error.message);
    } on TypeError catch (error) {
      _error(response, HttpStatus.badRequest, error.toString());
    }
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
    final bytes = BytesBuilder(copy: false);
    await for (final chunk in request) {
      bytes.add(chunk);
      if (bytes.length > maxBodyBytes) throw _BodyTooLarge();
    }

    final content = utf8.decode(bytes.takeBytes());
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

class _BodyTooLarge implements Exception {}
