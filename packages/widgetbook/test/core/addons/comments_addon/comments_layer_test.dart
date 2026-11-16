import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/addons/comments_addon/comment.dart';
import 'package:widgetbook/src/core/addons/comments_addon/comments_client.dart';
import 'package:widgetbook/src/core/addons/comments_addon/comments_layer.dart';

class _FakeClient implements CommentsClient {
  _FakeClient({this.reachable = true});

  final bool reachable;
  final comments = <Map<String, dynamic>>[];
  List<int>? lastScreenshot;

  @override
  int get port => 0;

  @override
  Future<String> root() async {
    if (!reachable) throw Exception('Connection refused');
    return '/project';
  }

  @override
  Future<List<StoryComment>> list(String storyPath) async {
    return comments.map(StoryComment.fromJson).toList();
  }

  @override
  Future<void> create({
    required String storyPath,
    required String storyUrl,
    required String text,
    required CommentAnchor anchor,
    List<int>? screenshot,
  }) async {
    lastScreenshot = screenshot;
    comments.add({
      'id': 'c${comments.length}',
      'status': 'draft',
      'anchor': anchor.toJson(),
      'messages': [
        {'author': 'user', 'text': text},
      ],
    });
  }

  @override
  Future<void> submit(String storyPath) async {
    for (final comment in comments) {
      if (comment['status'] == 'draft') comment['status'] = 'open';
    }
  }

  @override
  Future<void> setStatus(String id, CommentStatus status) async {
    comments.firstWhere((c) => c['id'] == id)['status'] = status.name;
  }

  @override
  Future<void> reply(String id, String text) async {}

  @override
  Future<void> delete(String id) async {
    comments.removeWhere((c) => c['id'] == id);
  }
}

class _Story extends StatelessWidget {
  const _Story({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var i = 0; i < 20; i++)
          SizedBox(
            height: 100,
            child: TextButton(
              onPressed: onPressed,
              child: Text('Item $i'),
            ),
          ),
      ],
    );
  }
}

void main() {
  Future<void> pumpLayer(
    WidgetTester tester,
    _FakeClient client, {
    VoidCallback? onPressed,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CommentsLayer(
            client: client,
            storyPath: 'widgets/List/Default',
            storyUrl: '/?path=widgets/List/Default',
            pollInterval: const Duration(milliseconds: 100),
            child: _Story(onPressed: onPressed ?? () {}),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  Future<void> unmount(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
  }

  Future<void> addComment(
    WidgetTester tester,
    String item,
    String text,
  ) async {
    await tester.tapAt(tester.getCenter(find.text(item)));
    await tester.pump();
    await tester.enterText(find.byType(TextField), text);
    await tester.runAsync(() async {
      await tester.testTextInput.receiveAction(TextInputAction.send);
      await Future<void>.delayed(const Duration(milliseconds: 200));
    });
    await tester.pump();
    await tester.pump();
  }

  Offset pinCenter(WidgetTester tester, String number) {
    return tester.getCenter(find.text(number));
  }

  group('$CommentsLayer', () {
    testWidgets('asks to start the server when it is unreachable', (
      tester,
    ) async {
      await pumpLayer(tester, _FakeClient(reachable: false));

      expect(
        find.text('Run `widgetbook mcp` to enable comments'),
        findsOneWidget,
      );
      await unmount(tester);
    });

    testWidgets('pins a comment to the clicked widget without tapping it', (
      tester,
    ) async {
      final client = _FakeClient();
      var pressed = 0;
      await pumpLayer(tester, client, onPressed: () => pressed++);

      await tester.tap(find.text('Comment'));
      await tester.pump();
      await addComment(tester, 'Item 2', 'Use a larger text style');

      expect(pressed, 0);
      final anchor = client.comments.single['anchor'] as Map;
      expect((anchor['location'] as Map)['widget'], 'Text');
      expect((anchor['location'] as Map)['occurrence'], 2);
      expect(client.lastScreenshot, isNotEmpty);
      expect(find.text('Commenting · 1'), findsOneWidget);
      await unmount(tester);
    });

    testWidgets('fits the comment UI around small stories', (tester) async {
      final client = _FakeClient();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: CommentsLayer(
                client: client,
                storyPath: 'widgets/Button/Default',
                storyUrl: '/?path=widgets/Button/Default',
                child: TextButton(onPressed: () {}, child: const Text('Go')),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      await tester.tap(find.text('Comment'));
      await tester.pump();
      await addComment(tester, 'Go', 'Use the primary style');

      expect(tester.takeException(), isNull);
      expect(client.comments.single['anchor'], isNotNull);
      expect(find.text('Commenting · 1'), findsOneWidget);
      await unmount(tester);
    });

    testWidgets('moves pins with the scrolled content', (tester) async {
      final client = _FakeClient();
      await pumpLayer(tester, client);
      await tester.tap(find.text('Comment'));
      await tester.pump();
      await addComment(tester, 'Item 3', 'Too much padding');

      final before = pinCenter(tester, '1');
      final scroll = tester.state<ScrollableState>(find.byType(Scrollable));
      scroll.position.jumpTo(120);
      await tester.pump();
      await tester.pump();

      expect(pinCenter(tester, '1'), before - const Offset(0, 120));
      await unmount(tester);
    });

    testWidgets('scrolls a pinned widget back into view', (tester) async {
      final client = _FakeClient();
      await pumpLayer(tester, client);
      await tester.tap(find.text('Comment'));
      await tester.pump();
      await addComment(tester, 'Item 0', 'Larger title');

      final scroll = tester.state<ScrollableState>(find.byType(Scrollable));
      scroll.position.jumpTo(700);
      await tester.pump();
      await tester.pump();

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();

      expect(scroll.position.pixels, lessThan(700));
      expect(find.textContaining('Larger title'), findsOneWidget);
      await unmount(tester);
    });

    testWidgets('submits drafts and resolves comments', (tester) async {
      final client = _FakeClient();
      await pumpLayer(tester, client);
      await tester.tap(find.text('Comment'));
      await tester.pump();
      await addComment(tester, 'Item 1', 'Use the brand color');

      await tester.tap(find.text('Submit'));
      await tester.pump();
      await tester.pump();
      expect(client.comments.single['status'], 'open');

      await tester.tap(find.text('1'));
      await tester.pump();
      expect(find.text('Waiting for the agent'), findsOneWidget);

      await tester.tap(find.text('Resolve'));
      await tester.pump();
      await tester.pump();

      expect(client.comments.single['status'], 'resolved');
      expect(find.text('1'), findsNothing);
      await unmount(tester);
    });
  });
}
