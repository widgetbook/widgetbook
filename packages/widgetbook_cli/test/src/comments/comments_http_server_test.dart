import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

void main() {
  group('$CommentsHttpServer', () {
    late Directory root;
    late CommentStore store;
    late CommentsHttpServer server;
    late HttpClient client;

    setUp(() async {
      root = Directory.systemTemp.createTempSync('comments');
      store = CommentStore(root: root.path);
      server = CommentsHttpServer(store);
      await server.start(port: 0);
      client = HttpClient();
    });

    tearDown(() async {
      client.close(force: true);
      await server.close();
      await store.close();
      root.deleteSync(recursive: true);
    });

    Future<(int, Map<String, dynamic>)> send(
      String method,
      String path, [
      Map<String, Object?>? body,
    ]) async {
      final request = await client.openUrl(
        method,
        Uri.parse('http://127.0.0.1:${server.port}$path'),
      );
      if (body != null) request.write(jsonEncode(body));
      final response = await request.close();
      final json = jsonDecode(await utf8.decodeStream(response));
      return (response.statusCode, (json as Map).cast<String, dynamic>());
    }

    test('allows browsers on loopback origins', () async {
      final preflight = await client.openUrl(
        'OPTIONS',
        Uri.parse('http://127.0.0.1:${server.port}/comments'),
      );
      preflight.headers
        ..set('origin', 'http://localhost:61234')
        ..set('access-control-request-method', 'POST');
      final preflightResponse = await preflight.close();
      await preflightResponse.drain<void>();

      expect(preflightResponse.statusCode, HttpStatus.noContent);
      expect(
        preflightResponse.headers.value('access-control-allow-origin'),
        'http://localhost:61234',
      );
      expect(
        preflightResponse.headers.value('access-control-allow-methods'),
        contains('PATCH'),
      );

      final request = await client.getUrl(
        Uri.parse('http://127.0.0.1:${server.port}/info'),
      );
      request.headers.set('origin', 'http://127.0.0.1:61234');
      final response = await request.close();
      await response.drain<void>();

      expect(response.statusCode, HttpStatus.ok);
      expect(
        response.headers.value('access-control-allow-origin'),
        'http://127.0.0.1:61234',
      );
    });

    test('rejects browsers on other origins', () async {
      final request = await client.postUrl(
        Uri.parse('http://127.0.0.1:${server.port}/reviews'),
      );
      request.headers.set('origin', 'https://example.com');
      final response = await request.close();
      await response.drain<void>();

      expect(response.statusCode, HttpStatus.forbidden);
      expect(response.headers.value('access-control-allow-origin'), isNull);
    });

    test('keeps running after a request it cannot handle', () async {
      final (status, _) = await send('POST', '/comments', {
        'storyPath': 'widgets/Card/Default',
        'text': 'Use a larger title',
        'anchor': {
          'location': {'uri': 'file://host/etc/passwd', 'line': 1},
        },
      });
      expect(status, isNot(HttpStatus.internalServerError));

      final (infoStatus, _) = await send('GET', '/info');
      expect(infoStatus, HttpStatus.ok);
    });

    test('rejects requests addressed to other hosts', () async {
      final request = await client.getUrl(
        Uri.parse('http://127.0.0.1:${server.port}/comments'),
      );
      request.headers.host = 'rebound.example';
      final response = await request.close();
      await response.drain<void>();

      expect(response.statusCode, HttpStatus.forbidden);
    });

    test('rejects comments on code of another project', () async {
      final (status, body) = await send('POST', '/comments', {
        'storyPath': 'widgets/Card/Default',
        'text': 'Use a larger title',
        'screenshot': base64Encode([1, 2, 3]),
        'anchor': {
          'location': {
            'uri': 'file:///elsewhere/lib/card.dart',
            'file': '/elsewhere/lib/card.dart',
          },
        },
      });

      expect(status, HttpStatus.conflict);
      expect(body['error'], contains('/elsewhere/lib/card.dart'));
      expect(store.list(), isEmpty);
      expect(store.directory.existsSync(), isFalse);
    });

    test('rejects bodies above the size limit', () async {
      final limited = CommentsHttpServer(store, maxBodyBytes: 100);
      await limited.start(port: 0);
      addTearDown(limited.close);

      final request = await client.postUrl(
        Uri.parse('http://127.0.0.1:${limited.port}/comments'),
      );
      request.write(jsonEncode({'text': 'x' * 200}));
      final response = await request.close();
      await response.drain<void>();

      expect(response.statusCode, HttpStatus.requestEntityTooLarge);
    });

    test('recognizes loopback origins', () {
      expect(
        CommentsHttpServer.isLoopbackOrigin('http://localhost:8080'),
        isTrue,
      );
      expect(CommentsHttpServer.isLoopbackOrigin('http://[::1]:8080'), isTrue);
      expect(
        CommentsHttpServer.isLoopbackOrigin('http://localhost.evil.com'),
        isFalse,
      );
      expect(CommentsHttpServer.isLoopbackOrigin('null'), isFalse);
    });

    test('returns the project root', () async {
      final (status, body) = await send('GET', '/info');

      expect(status, HttpStatus.ok);
      expect(body['root'], root.path);
    });

    test('creates, submits and resolves a comment', () async {
      final (_, created) = await send('POST', '/comments', {
        'storyPath': 'widgets/Card/Default',
        'storyUrl': '/?path=widgets/Card/Default',
        'text': 'Use a larger title',
        'screenshot': base64Encode([1, 2, 3]),
      });
      final id = created['id'] as String;
      expect(created['status'], 'draft');

      final (_, review) = await send('POST', '/reviews', {});
      expect(review['comments'], hasLength(1));

      final (_, listed) = await send(
        'GET',
        '/comments?story=widgets/Card/Default',
      );
      expect((listed['comments'] as List).single['status'], 'open');

      final (_, resolved) = await send('PATCH', '/comments/$id', {
        'status': 'resolved',
      });
      expect(resolved['status'], 'resolved');
    });

    test('rejects invalid status changes', () async {
      final (_, created) = await send('POST', '/comments', {
        'storyPath': 'widgets/Card/Default',
        'text': 'Use a larger title',
      });

      final (status, body) = await send(
        'PATCH',
        '/comments/${created['id']}',
        {'status': 'done'},
      );

      expect(status, HttpStatus.conflict);
      expect(body['error'], contains('"draft" to "done"'));
    });

    test('responds with not found for unknown comments and routes', () async {
      expect((await send('DELETE', '/comments/unknown')).$1, 404);
      expect((await send('GET', '/unknown')).$1, 404);
    });

    test('responds with bad request for invalid bodies', () async {
      final (status, _) = await send('POST', '/comments', {'text': 1});

      expect(status, HttpStatus.badRequest);
    });
  });
}
