import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' hide Viewport;
import 'package:widgetbook/src/core/addons/comments_addon/comment.dart';
import 'package:widgetbook/src/core/addons/comments_addon/comments_client.dart';
import 'package:widgetbook/src/core/addons/comments_addon/comments_layer.dart';
import 'package:widgetbook/src/core/addons/viewport_addon/viewport.dart';
import 'package:widgetbook/src/core/addons/viewport_addon/viewports/ios_viewports.dart';

class _FakeClient implements CommentsClient {
  _FakeClient({this.reachable = true});

  final bool reachable;
  final comments = <Map<String, dynamic>>[];
  List<int>? lastScreenshot;
  Object? createError;
  Completer<void>? listGate;

  @override
  int get port => 0;

  @override
  Future<String> root() async {
    if (!reachable) throw Exception('Connection refused');
    return '/project';
  }

  @override
  Future<List<StoryComment>> list(String storyPath) async {
    final snapshot = comments
        .where((comment) => comment['storyPath'] == storyPath)
        .toList();
    await listGate?.future;
    return snapshot.map(StoryComment.fromJson).toList();
  }

  @override
  Future<void> create({
    required String storyPath,
    required String storyUrl,
    required String text,
    required CommentAnchor anchor,
    List<int>? screenshot,
  }) async {
    if (createError case final error?) throw error;
    lastScreenshot = screenshot;
    comments.add({
      'id': 'c${comments.length}',
      'storyPath': storyPath,
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

class _LessonSummary extends StatelessWidget {
  const _LessonSummary({required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lesson complete')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 101,
              itemBuilder: (context, index) => index == 0
                  ? const _Topics()
                  : ListTile(title: Text('Phrase $index')),
            ),
          ),
          FilledButton(onPressed: onNext, child: const Text('Next lesson')),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _Topics extends StatelessWidget {
  const _Topics();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final topic in ['Greetings', 'Numbers', 'Weekdays', 'Time'])
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(topic),
            ),
        ],
      ),
    );
  }
}

void main() {
  Future<void> pumpLayer(
    WidgetTester tester,
    _FakeClient client, {
    VoidCallback? onPressed,
    String storyPath = 'widgets/List/Default',
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CommentsLayer(
            client: client,
            storyPath: storyPath,
            storyUrl: '/?path=$storyPath',
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

  void expectPinOn(WidgetTester tester, String number, Finder target) {
    final distance = (pinCenter(tester, number) - tester.getCenter(target));
    expect(distance.distance, lessThan(1));
  }

  group('$CommentsLayer in a scrollable screen of a device frame', () {
    Future<void> pumpScreen(
      WidgetTester tester,
      _FakeClient client, {
      VoidCallback? onNext,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Viewport(
                data: IosViewports.iPhone13,
                frameless: false,
                child: CommentsLayer(
                  client: client,
                  storyPath: 'screens/LessonSummary/Default',
                  storyUrl: '/?path=screens/LessonSummary/Default',
                  child: _LessonSummary(onNext: onNext ?? () {}),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_comment_outlined));
      await tester.pump();
    }

    ScrollableState scrollableOf(WidgetTester tester, Finder finder) {
      return tester.state<ScrollableState>(
        find.descendant(of: finder, matching: find.byType(Scrollable)).first,
      );
    }

    testWidgets('restores a lazily built item that was scrolled away', (
      tester,
    ) async {
      final client = _FakeClient();
      await pumpScreen(tester, client);
      await addComment(tester, 'Phrase 3', 'Use the phrase card');
      expectPinOn(tester, '1', find.text('Phrase 3'));

      scrollableOf(tester, find.byType(_LessonSummary)).position.jumpTo(3000);
      await tester.pump();
      await tester.pump();
      expect(find.text('Phrase 3'), findsNothing);
      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();

      expectPinOn(tester, '1', find.text('Phrase 3'));
      expect(find.textContaining('Use the phrase card'), findsOneWidget);
      await unmount(tester);
    });

    testWidgets('keeps the pin on its list item when the story is reopened', (
      tester,
    ) async {
      final client = _FakeClient();
      await pumpScreen(tester, client);
      final list = find.byType(_LessonSummary);
      scrollableOf(tester, list).position.jumpTo(700);
      await tester.pump();
      await addComment(tester, 'Phrase 17', 'Use a larger text style');
      expectPinOn(tester, '1', find.text('Phrase 17'));

      await unmount(tester);
      await pumpScreen(tester, client);
      await tester.pump();

      for (final phrase in find.textContaining('Phrase ').evaluate()) {
        final text = (phrase.widget as Text).data!;
        if (text == 'Phrase 17') continue;
        final distance =
            pinCenter(tester, '1') - tester.getCenter(find.text(text));
        expect(distance.distance, greaterThan(1), reason: 'pinned to $text');
      }

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();

      expectPinOn(tester, '1', find.text('Phrase 17'));
      await unmount(tester);
    });

    testWidgets('keeps pins of scrolled away items at the edge of the list', (
      tester,
    ) async {
      final client = _FakeClient();
      await pumpScreen(tester, client);
      await addComment(tester, 'Phrase 3', 'Use the phrase card');
      final list = find
          .descendant(
            of: find.byType(_LessonSummary),
            matching: find.byType(Scrollable),
          )
          .first;
      final scrollable = tester.state<ScrollableState>(list);

      scrollable.position.jumpTo(3000);
      await tester.pump();
      await tester.pump();

      expect(find.text('Phrase 3'), findsNothing);
      expect(
        (pinCenter(tester, '1').dy - tester.getRect(list).top).abs(),
        lessThan(1),
      );

      scrollable.position.jumpTo(0);
      await tester.pump();
      await tester.pump();

      expectPinOn(tester, '1', find.text('Phrase 3'));
      await unmount(tester);
    });

    testWidgets('follows a nested horizontal list', (tester) async {
      final client = _FakeClient();
      await pumpScreen(tester, client);
      await addComment(tester, 'Weekdays', 'Use chips for topics');

      scrollableOf(tester, find.byType(_Topics)).position.jumpTo(60);
      await tester.pump();
      await tester.pump();

      expectPinOn(tester, '1', find.text('Weekdays'));
      expect(
        (client.comments.single['anchor'] as Map)['scroll'],
        containsPair('pixels', 0.0),
      );
      await unmount(tester);
    });

    testWidgets('does not press buttons of the screen while commenting', (
      tester,
    ) async {
      final client = _FakeClient();
      var pressed = 0;
      await pumpScreen(tester, client, onNext: () => pressed++);

      await addComment(tester, 'Next lesson', 'Make it sticky');

      expect(pressed, 0);
      expect(
        ((client.comments.single['anchor'] as Map)['location']
            as Map)['widget'],
        'Text',
      );
      await unmount(tester);
    });
  });

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
      expect(find.text('1 draft'), findsOneWidget);
      await unmount(tester);
    });

    testWidgets('keeps the comment and shows why it could not be saved', (
      tester,
    ) async {
      final client = _FakeClient()
        ..createError = Exception(
          '{"error":"The commented widget is not part of /other"}',
        );
      await pumpLayer(tester, client);
      await tester.tap(find.text('Comment'));
      await tester.pump();

      await addComment(tester, 'Item 2', 'Use a larger text style');

      expect(client.comments, isEmpty);
      expect(
        find.textContaining('The commented widget is not part of /other'),
        findsOneWidget,
      );
      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.controller!.text, 'Use a larger text style');
      await unmount(tester);
    });

    testWidgets('ignores comments of the previous story', (tester) async {
      final client = _FakeClient()
        ..comments.add({
          'id': 'a',
          'storyPath': 'widgets/List/A',
          'status': 'open',
          'anchor': {
            'point': {'x': 0.5, 'y': 0.1},
          },
          'messages': [
            {'author': 'user', 'text': 'On story A'},
          ],
        });
      await pumpLayer(tester, client, storyPath: 'widgets/List/A');
      expect(find.text('1'), findsWidgets);

      client.listGate = Completer<void>();
      await tester.pump(const Duration(milliseconds: 100));
      await pumpLayer(tester, client, storyPath: 'widgets/List/B');

      final staleGate = client.listGate!;
      client.listGate = Completer<void>();
      staleGate.complete();
      await tester.pump();
      await tester.pump();

      expect(find.text('Comment'), findsOneWidget);
      expect(find.text('1'), findsNothing);

      client.listGate!.complete();
      client.listGate = null;
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
      expect(find.text('1 draft'), findsOneWidget);
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

    testWidgets('marks pins whose widget may have changed', (tester) async {
      final client = _FakeClient();
      await pumpLayer(tester, client);
      await tester.tap(find.text('Comment'));
      await tester.pump();
      await addComment(tester, 'Item 2', 'Use a larger text style');
      await unmount(tester);

      final anchor = client.comments.single['anchor'] as Map<String, dynamic>;
      expect(anchor['signature'], 'Item 2');
      anchor['signature'] = 'Removed item';

      await pumpLayer(tester, client);
      await tester.tap(find.text('1?'));
      await tester.pump();

      expect(
        find.textContaining('It was pinned to "Removed item"'),
        findsOneWidget,
      );
      await unmount(tester);
    });

    Future<void> openComposer(WidgetTester tester, String item) async {
      await tester.tap(find.text('Comment'));
      await tester.pump();
      await tester.tapAt(tester.getCenter(find.text(item)));
      await tester.pump();
    }

    Future<void> settle(WidgetTester tester) async {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 200)),
      );
      await tester.pump();
      await tester.pump();
    }

    testWidgets('adds a comment with its button', (tester) async {
      final client = _FakeClient();
      await pumpLayer(tester, client);
      await openComposer(tester, 'Item 2');
      await tester.enterText(find.byType(TextField), 'Use a larger title');

      await tester.runAsync(() async {
        await tester.tap(find.text('Add comment'));
        await Future<void>.delayed(const Duration(milliseconds: 200));
      });
      await settle(tester);

      expect(client.comments.single['status'], 'draft');
      expect(find.text('1 draft'), findsOneWidget);
      expect(find.text('Send 1 to agent'), findsOneWidget);
      await unmount(tester);
    });

    testWidgets('adds a comment with Enter, and Shift+Enter keeps typing', (
      tester,
    ) async {
      final client = _FakeClient();
      await pumpLayer(tester, client);
      await openComposer(tester, 'Item 2');
      await tester.enterText(find.byType(TextField), 'Use a larger title');

      await tester.sendKeyDownEvent(LogicalKeyboardKey.shift);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.shift);
      await tester.pump();
      expect(client.comments, isEmpty);

      await tester.runAsync(() async {
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await Future<void>.delayed(const Duration(milliseconds: 200));
      });
      await settle(tester);

      expect(client.comments, hasLength(1));
      await unmount(tester);
    });

    testWidgets('discards all drafts', (tester) async {
      final client = _FakeClient();
      await pumpLayer(tester, client);
      await tester.tap(find.text('Comment'));
      await tester.pump();
      await addComment(tester, 'Item 1', 'First');
      await addComment(tester, 'Item 3', 'Second');
      expect(find.text('2 drafts'), findsOneWidget);
      expect(find.text('Send 2 to agent'), findsOneWidget);

      await tester.tap(find.text('Discard'));
      await settle(tester);

      expect(client.comments, isEmpty);
      expect(find.text('Click a widget to comment'), findsOneWidget);
      await unmount(tester);
    });

    testWidgets('says when the agent finished a comment', (tester) async {
      final client = _FakeClient();
      await pumpLayer(tester, client);
      await tester.tap(find.text('Comment'));
      await tester.pump();
      await addComment(tester, 'Item 1', 'Use the brand color');
      client.comments.single['status'] = 'done';
      client.comments.single['messages'] = [
        ...client.comments.single['messages'] as List,
        {'author': 'agent', 'text': 'Switched to the brand color'},
      ];
      await tester.pump(const Duration(milliseconds: 100));
      await settle(tester);

      await tester.tap(find.text('1'));
      await tester.pump();

      expect(find.text('Agent finished · check and resolve'), findsOneWidget);
      expect(find.textContaining('Done'), findsNothing);
      await unmount(tester);
    });

    testWidgets('submits drafts and resolves comments', (tester) async {
      final client = _FakeClient();
      await pumpLayer(tester, client);
      await tester.tap(find.text('Comment'));
      await tester.pump();
      await addComment(tester, 'Item 1', 'Use the brand color');

      await tester.tap(find.text('Send 1 to agent'));
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
