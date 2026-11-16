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
