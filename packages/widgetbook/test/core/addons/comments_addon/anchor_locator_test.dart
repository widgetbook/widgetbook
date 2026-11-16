import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

void main() {
  final storyKey = GlobalKey();

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
}
