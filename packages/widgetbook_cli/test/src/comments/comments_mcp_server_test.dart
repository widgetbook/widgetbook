import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_mcp/client.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

void main() {
  group('$CommentsMcpServer', () {
    late Directory root;
    late CommentStore store;
    late CommentsMcpServer server;
    late bool servingUi;
    late ServerConnection connection;
    late InitializeResult initialization;
    late StreamController<Map<String, Object?>> channelEvents;

    setUp(() async {
      root = Directory.systemTemp.createTempSync('comments');
      store = CommentStore(root: root.path);
      channelEvents = StreamController.broadcast();

      final channel = StreamChannelController<String>();
      servingUi = true;
      server = CommentsMcpServer(
        channel.local,
        store: store,
        version: '1.0.0',
        isServingUi: () => servingUi,
      );
      connection = MCPClient(
        Implementation(name: 'test', version: '1.0.0'),
      ).connectServer(channel.foreign);
      connection.registerNotificationHandler<Notification>(
        CommentsMcpServer.channelMethod,
        (notification) =>
            channelEvents.add(notification as Map<String, Object?>),
      );

      initialization = await connection.initialize(
        InitializeRequest(
          protocolVersion: ProtocolVersion.latestSupported,
          capabilities: ClientCapabilities(),
          clientInfo: Implementation(name: 'test', version: '1.0.0'),
        ),
      );
      connection.notifyInitialized();
    });

    tearDown(() async {
      await connection.shutdown();
      await server.shutdown();
      await store.close();
      await channelEvents.close();
      root.deleteSync(recursive: true);
    });

    Future<CallToolResult> call(
      String name, [
      Map<String, Object?>? arguments,
    ]) {
      return connection.callTool(
        CallToolRequest(name: name, arguments: arguments),
      );
    }

    Object? decode(CallToolResult result) {
      return jsonDecode((result.content.first as TextContent).text);
    }

    Comment submitComment() {
      final comment = store.create(
        storyPath: 'widgets/Card/Default',
        text: 'Use a larger title',
        anchor: {
          'location': {
            'widget': 'Text',
            'file': 'lib/card.dart',
            'line': 12,
            'column': 7,
          },
        },
        screenshotPng: base64Decode(_pngPixel),
      );
      store.submit();
      return comment;
    }

    test('declares the channel capability and instructions', () {
      expect(initialization.capabilities.experimental, {
        'claude/channel': <String, Object?>{},
      });
      expect(initialization.instructions, contains('wait_for_comments'));
    });

    test('lists comments that wait for the agent', () async {
      final comment = submitComment();
      store.create(storyPath: 'widgets/Card/Default', text: 'Draft');

      final listed = decode(await call('list_comments')) as List;

      expect(listed, [
        {
          'id': comment.id,
          'status': 'open',
          'storyPath': 'widgets/Card/Default',
          'text': 'Use a larger title',
          'widget': 'Text at lib/card.dart:12:7',
          'replies': 0,
        },
      ]);
    });

    test('returns a comment with its screenshot', () async {
      final comment = submitComment();

      final result = await call('get_comment', {'id': comment.id});

      expect((decode(result) as Map)['id'], comment.id);
      expect(result.content.last, isA<ImageContent>());
    });

    test('lets the agent reply and mark a comment as done', () async {
      final comment = submitComment();

      await call('set_comment_status', {
        'id': comment.id,
        'status': 'inProgress',
      });
      await call('reply_to_comment', {
        'id': comment.id,
        'text': 'Switched to titleLarge',
      });
      await call('set_comment_status', {'id': comment.id, 'status': 'done'});

      final stored = store.get(comment.id);
      expect(stored.status, CommentStatus.done);
      expect(stored.messages.last.author, CommentAuthor.agent);
    });

    test('reports invalid status changes as tool errors', () async {
      final comment = submitComment();

      final result = await call('set_comment_status', {
        'id': comment.id,
        'status': 'resolved',
      });

      expect(result.isError, isTrue);
    });

    test('wakes every waiting call for a review', () async {
      final first = call('wait_for_comments');
      final second = call('wait_for_comments');
      await Future<void>.delayed(Duration.zero);

      final comment = submitComment();

      expect((decode(await first) as List).single['id'], comment.id);
      expect((decode(await second) as List).single['id'], comment.id);
    });

    test('explains that it does not receive reviews without the UI', () async {
      servingUi = false;

      final result = await call('wait_for_comments');

      expect(result.isError, isTrue);
      expect(
        (result.content.single as TextContent).text,
        contains('another one already serves the Widgetbook UI'),
      );
    });

    test('waits for the next submitted review', () async {
      final waiting = call('wait_for_comments');
      await Future<void>.delayed(Duration.zero);

      final comment = submitComment();
      final returned = decode(await waiting) as List;

      expect(returned.single['id'], comment.id);
    });

    test('returns reviews submitted before waiting', () async {
      final comment = submitComment();

      final returned = decode(await call('wait_for_comments')) as List;
      expect(returned.single['id'], comment.id);

      final timedOut = await call('wait_for_comments', {'timeoutSeconds': 1});
      expect(decode(timedOut), isEmpty);
    });

    test('pushes submitted reviews to the channel', () async {
      final event = channelEvents.stream.first;

      final comment = submitComment();

      final params = await event;
      expect(params['content'], contains(comment.id));
      expect(params['meta'], {
        'count': '1',
        'stories': 'widgets/Card/Default',
      });
    });
  });
}

const _pngPixel =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==';
