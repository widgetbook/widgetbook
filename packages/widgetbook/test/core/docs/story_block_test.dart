import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/workbench/docs_preview.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

// Fixed-height widget (100px)
class _FixedHeightArgs extends StoryArgs<SizedBox> {
  const _FixedHeightArgs();

  @override
  List<Arg?> get list => const [];
}

class _FixedHeightStory extends Story<SizedBox, _FixedHeightArgs> {
  _FixedHeightStory()
    : super(
        name: 'Fixed Height',
        args: const _FixedHeightArgs(),
        builder: (_, __) => const SizedBox(height: 100, child: Placeholder()),
      );
}

// Scaffold screen (needs bounded constraints)
class _ScaffoldArgs extends StoryArgs<Scaffold> {
  const _ScaffoldArgs();

  @override
  List<Arg?> get list => const [];
}

class _ScaffoldStory extends Story<Scaffold, _ScaffoldArgs> {
  _ScaffoldStory()
    : super(
        name: 'Scaffold Screen',
        args: const _ScaffoldArgs(),
        builder: (_, __) => Scaffold(
          appBar: AppBar(title: const Text('Screen')),
          body: const Center(child: Text('Content')),
        ),
      );
}

// Column + Expanded (needs bounded constraints)
class _NestedScrollArgs extends StoryArgs<Column> {
  const _NestedScrollArgs();

  @override
  List<Arg?> get list => const [];
}

class _NestedScrollStory extends Story<Column, _NestedScrollArgs> {
  _NestedScrollStory()
    : super(
        name: 'Nested Scroll',
        args: const _NestedScrollArgs(),
        builder: (_, __) => Column(
          children: [
            const SizedBox(height: 50, child: Placeholder()),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (_, i) => ListTile(title: Text('Item $i')),
              ),
            ),
          ],
        ),
      );
}

// Tall content (many items, large intrinsic height)
class _TallContentArgs extends StoryArgs<Column> {
  const _TallContentArgs();

  @override
  List<Arg?> get list => const [];
}

class _TallContentStory extends Story<Column, _TallContentArgs> {
  _TallContentStory()
    : super(
        name: 'Tall Content',
        args: const _TallContentArgs(),
        builder: (_, __) => Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            50,
            (i) => ListTile(title: Text('Item $i')),
          ),
        ),
      );
}

// Helpers
WidgetbookState _createDocsState({
  required List<Story<Widget, StoryArgs<Widget>>> stories,
  StoriesDocBlock storiesBlock = const StoriesDocBlock(),
}) {
  final component = Component<Widget, StoryArgs<Widget>>(
    name: 'TestComponent',
    stories: stories,
    docsBuilder: (blocks) => [
      const ComponentNameDocBlock(),
      storiesBlock,
    ],
  );

  return WidgetbookState(
    path: 'TestComponent/Docs',
    config: Config(components: [component]),
  );
}

// Tests
void main() {
  group('$StoryDocBlock', () {
    group('with default height (fixed at defaultStoryHeight)', () {
      testWidgets(
        'uses defaultStoryHeight when no height is specified',
        (tester) async {
          // Uses const StoriesDocBlock() — the true default, no explicit height
          final state = _createDocsState(stories: [_FixedHeightStory()]);

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const DocsPreview(),
          );
          await tester.pumpAndSettle();

          final widgetDocBlock = find.byType(WidgetDocBlock);
          expect(widgetDocBlock, findsOneWidget);

          expect(
            find.descendant(
              of: widgetDocBlock,
              matching: find.byWidgetPredicate(
                (w) => w is SizedBox && w.height == defaultStoryHeight,
              ),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders a Scaffold story without layout errors',
        (tester) async {
          final state = _createDocsState(stories: [_ScaffoldStory()]);

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const DocsPreview(),
          );
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
          expect(find.text('Scaffold Screen'), findsOneWidget);
        },
      );

      testWidgets(
        'renders a Column+Expanded story without layout errors',
        (tester) async {
          final state = _createDocsState(stories: [_NestedScrollStory()]);

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const DocsPreview(),
          );
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
          expect(find.text('Nested Scroll'), findsOneWidget);
        },
      );

      testWidgets(
        'wraps story preview in a SizedBox with the given height',
        (tester) async {
          final state = _createDocsState(
            stories: [_FixedHeightStory()],
            storiesBlock: const StoriesDocBlock(height: 400),
          );

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const DocsPreview(),
          );
          await tester.pumpAndSettle();

          final widgetDocBlock = find.byType(WidgetDocBlock);
          expect(widgetDocBlock, findsOneWidget);

          final sizedBox = tester.widget<SizedBox>(
            find.descendant(
              of: widgetDocBlock,
              matching: find.byWidgetPredicate(
                (w) => w is SizedBox && w.height == 400,
              ),
            ),
          );
          expect(sizedBox.height, 400);
        },
      );
    });

    group('unconstrained', () {
      testWidgets(
        'renders a fixed-height story at its natural size',
        (tester) async {
          final state = _createDocsState(
            stories: [_FixedHeightStory()],
            storiesBlock: const StoriesDocBlock.unconstrained(),
          );

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const DocsPreview(),
          );
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
          expect(find.text('Fixed Height'), findsOneWidget);
        },
      );

      testWidgets(
        'renders tall content without constraint',
        (tester) async {
          final state = _createDocsState(
            stories: [_TallContentStory()],
            storiesBlock: const StoriesDocBlock.unconstrained(),
          );

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const DocsPreview(),
          );
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
          expect(find.text('Tall Content'), findsOneWidget);
        },
      );
    });

    group('unconstrained Scaffold in SingleChildScrollView', () {
      testWidgets(
        'Scaffold fails with infinite constraints when no height is set',
        (tester) async {
          final story = _ScaffoldStory();
          final component = Component<Scaffold, _ScaffoldArgs>(
            name: 'TestComponent',
            stories: [story],
          );
          final config = Config(components: [component]);
          final state = WidgetbookState(
            path: 'TestComponent/Docs',
            config: config,
          );

          await tester.pumpWidgetWithState(
            state: state,
            builder: (context) {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      story.buildWithConfig(context, config),
                    ],
                  ),
                ),
              );
            },
          );
          await tester.pump();

          // The Scaffold gets infinite height and throws
          expect(tester.takeException(), isNotNull);
        },
      );
    });
  });
}
