import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/src/core/addons/comments_addon/anchor_locator.dart';
import 'package:widgetbook/src/core/addons/comments_addon/comment.dart';

class _Card extends StatelessWidget {
  const _Card(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Text(label),
    );
  }
}

class _Story extends StatelessWidget {
  const _Story();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var i = 0; i < 20; i++) _Card('Item $i'),
      ],
    );
  }
}

class _Labels extends StatelessWidget {
  const _Labels(this.labels);

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final label in labels) Text(label),
      ],
    );
  }
}

class _ScrollingLabels extends StatelessWidget {
  const _ScrollingLabels(this.labels);

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final label in labels) SizedBox(height: 100, child: Text(label)),
      ],
    );
  }
}

class _Pair extends StatelessWidget {
  const _Pair();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('First'),
        Text('Second'),
      ],
    );
  }
}

class _PairWithInsertedLine extends StatelessWidget {
  const _PairWithInsertedLine();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Inserted'),
        Text('First'),
        Text('Second'),
      ],
    );
  }
}

void main() {
  final storyKey = GlobalKey();

  Future<Element> pumpWidget(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RepaintBoundary(key: storyKey, child: child),
      ),
    );
    return storyKey.currentContext! as Element;
  }

  Future<Element> pumpStory(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RepaintBoundary(
          key: storyKey,
          child: const _Story(),
        ),
      ),
    );
    return storyKey.currentContext! as Element;
  }

  AnchorLocator locator() {
    return AnchorLocator(
      excludedPrefix: 'file:///does/not/exist/lib/',
    );
  }

  group('$AnchorLocator URIs', () {
    test('finds the package prefix of file, app and package URIs', () {
      expect(
        AnchorLocator.packagePrefix(
          'file:///repo/packages/widgetbook/lib/src/core/a.dart',
        ),
        'file:///repo/packages/widgetbook/lib/',
      );
      expect(
        AnchorLocator.packagePrefix('package:widgetbook/src/core/a.dart'),
        'package:widgetbook/',
      );
      expect(
        AnchorLocator.packagePrefix('org-dartlang-app:///main.dart'),
        null,
      );
    });

    test('excludes Flutter, Widgetbook and generated code', () {
      bool isLocal(String uri) {
        return AnchorLocator.isLocal(
          uri,
          excludedPrefix: 'package:widgetbook/',
        );
      }

      expect(isLocal('org-dartlang-app:///lib/card.dart'), isTrue);
      expect(isLocal('package:ui_kit/src/card.dart'), isTrue);
      expect(isLocal('file:///repo/app/lib/card.dart'), isTrue);
      expect(isLocal('package:widgetbook/src/core/workbench.dart'), isFalse);
      expect(isLocal('package:flutter/src/widgets/text.dart'), isFalse);
      expect(isLocal('org-dartlang-sdk:///lib/ui/text.dart'), isFalse);
      expect(isLocal('org-dartlang-app:///lib/card.stories.g.dart'), isFalse);
      expect(
        isLocal('file:///Users/me/.pub-cache/hosted/pub.dev/x/lib/x.dart'),
        isFalse,
      );
    });

    test('shows web locations relative to the app', () {
      expect(
        AnchorLocator.displayFile('org-dartlang-app:///lib/card.dart', '/repo'),
        'lib/card.dart',
      );
      expect(
        AnchorLocator.displayFile('package:ui_kit/card.dart', '/repo'),
        'package:ui_kit/card.dart',
      );
    });
  });

  group('$AnchorLocator', () {
    testWidgets('pins to the closest widget of the user code', (tester) async {
      final story = await pumpStory(tester);

      final anchor = locator().capture(
        story,
        tester.getCenter(find.text('Item 2')),
      );

      expect(anchor.location?.widget, 'Text');
      expect(anchor.location?.file, endsWith('anchor_locator_test.dart'));
      expect(anchor.occurrence, 2);
      expect(anchor.offset?.x, closeTo(0.5, 0.01));
      expect(anchor.chain.map((location) => location.widget), [
        'SizedBox',
        '_Card',
        'ListView',
        '_Story',
      ]);
      expect(anchor.scroll?.owner.widget, 'ListView');
    });

    testWidgets('follows the widget when the story scrolls', (tester) async {
      final story = await pumpStory(tester);
      final anchor = locator().capture(
        story,
        tester.getCenter(find.text('Item 3')),
      );

      await tester.drag(find.byType(ListView), const Offset(0, -150));
      await tester.pump();

      final resolved = locator().resolve(story, anchor)!;
      final box = resolved.element.findRenderObject()! as RenderBox;

      expect(resolved.exact, isTrue);
      expect(
        box.localToGlobal(box.size.center(Offset.zero)),
        tester.getCenter(find.text('Item 3')),
      );
    });

    testWidgets('restores the scroll position of lazily built items', (
      tester,
    ) async {
      final story = await pumpStory(tester);
      await tester.drag(find.byType(ListView), const Offset(0, -1500));
      await tester.pump();

      final anchor = locator().capture(
        story,
        tester.getCenter(find.text('Item 18')),
      );

      await tester.drag(find.byType(ListView), const Offset(0, 1500));
      await tester.pump();
      expect(find.text('Item 18'), findsNothing);

      expect(locator().restoreScroll(story, anchor), isTrue);
      await tester.pump();
      expect(find.text('Item 18'), findsOneWidget);
    });

    testWidgets('finds comments placed on another platform by their file', (
      tester,
    ) async {
      final story = await pumpStory(tester);
      final anchor = locator().capture(
        story,
        tester.getCenter(find.text('Item 4')),
      );
      final fromOtherPlatform = CommentAnchor(
        location: WidgetLocation(
          widget: anchor.location!.widget,
          file: anchor.location!.file,
          uri: 'org-dartlang-app:///elsewhere.dart',
          line: anchor.location!.line,
          column: anchor.location!.column,
        ),
        occurrence: anchor.occurrence,
        point: anchor.point,
      );

      final resolved = locator().resolve(story, fromOtherPlatform)!;

      expect((resolved.element.widget as Text).data, 'Item 4');
    });

    testWidgets('falls back to the widget type when lines moved', (
      tester,
    ) async {
      final story = await pumpStory(tester);
      final anchor = locator().capture(
        story,
        tester.getCenter(find.text('Item 1')),
      );
      final moved = CommentAnchor(
        location: WidgetLocation(
          widget: anchor.location!.widget,
          file: anchor.location!.file,
          line: anchor.location!.line + 3,
          column: 1,
        ),
        occurrence: anchor.occurrence,
        point: anchor.point,
      );

      final resolved = locator().resolve(story, moved)!;

      expect(resolved.element.widget, isA<Text>());
      expect((resolved.element.widget as Text).data, 'Item 1');
    });

    testWidgets('falls back to the enclosing widget when it was removed', (
      tester,
    ) async {
      final story = await pumpStory(tester);
      final anchor = locator().capture(
        story,
        tester.getCenter(find.text('Item 1')),
      );
      final removed = CommentAnchor(
        location: const WidgetLocation(
          widget: 'Icon',
          file: 'lib/removed.dart',
          line: 1,
          column: 1,
        ),
        point: anchor.point,
        chain: anchor.chain,
      );

      final resolved = locator().resolve(story, removed)!;

      expect(resolved.exact, isFalse);
      expect(resolved.element.widget, isA<SizedBox>());
    });
  });

  group('$AnchorLocator after code changes', () {
    String textOf(ResolvedAnchor resolved) {
      return (resolved.element.widget as Text).data!;
    }

    CommentAnchor captureText(Element story, WidgetTester tester, String text) {
      return locator().capture(story, tester.getCenter(find.text(text)));
    }

    testWidgets('keeps the pin when an item is inserted before it', (
      tester,
    ) async {
      var story = await pumpWidget(tester, const _Labels(['First', 'Second']));
      final anchor = captureText(story, tester, 'Second');

      story = await pumpWidget(
        tester,
        const _Labels(['Inserted', 'First', 'Second']),
      );
      final resolved = locator().resolve(story, anchor)!;

      expect(textOf(resolved), 'Second');
      expect(resolved.uncertain, isFalse);
    });

    testWidgets('keeps the pin when a list item is inserted before it', (
      tester,
    ) async {
      final labels = [for (var i = 0; i < 10; i++) 'Item $i'];
      var story = await pumpWidget(tester, _ScrollingLabels(labels));
      final anchor = captureText(story, tester, 'Item 2');

      story = await pumpWidget(
        tester,
        _ScrollingLabels(['Inserted', ...labels]),
      );
      final resolved = locator().resolve(story, anchor)!;

      expect(textOf(resolved), 'Item 2');
      expect(resolved.uncertain, isFalse);
    });

    testWidgets('keeps the pin when a line is inserted above it', (
      tester,
    ) async {
      var story = await pumpWidget(tester, const _Pair());
      final pinned = captureText(story, tester, 'Second');

      story = await pumpWidget(tester, const _PairWithInsertedLine());
      final shifted = captureText(story, tester, 'First').location!;
      final anchor = CommentAnchor(
        location: WidgetLocation(
          widget: pinned.location!.widget,
          file: shifted.file,
          uri: shifted.uri,
          line: shifted.line,
          column: shifted.column,
        ),
        signature: pinned.signature,
        point: pinned.point,
        chain: pinned.chain,
      );
      final resolved = locator().resolve(story, anchor)!;

      expect(textOf(resolved), 'Second');
      expect(resolved.uncertain, isFalse);
    });

    testWidgets('marks the pin uncertain when no widget shows its content', (
      tester,
    ) async {
      var story = await pumpWidget(tester, const _Labels(['First', 'Second']));
      final anchor = captureText(story, tester, 'Second');

      story = await pumpWidget(
        tester,
        const _Labels(['Alpha', 'Beta', 'Gamma']),
      );
      final resolved = locator().resolve(story, anchor)!;

      expect(resolved.uncertain, isTrue);
    });

    testWidgets('trusts the only candidate when its content changes', (
      tester,
    ) async {
      var story = await pumpWidget(tester, const _Labels(['0']));
      final anchor = captureText(story, tester, '0');

      story = await pumpWidget(tester, const _Labels(['1']));
      final resolved = locator().resolve(story, anchor)!;

      expect(textOf(resolved), '1');
      expect(resolved.uncertain, isFalse);
    });

    testWidgets('records what the widget shows', (tester) async {
      final story = await pumpWidget(tester, const _Pair());

      expect(captureText(story, tester, 'Second').signature, 'Second');
    });
  });
}
