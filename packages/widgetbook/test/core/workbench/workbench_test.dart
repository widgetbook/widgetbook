import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/core/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(MockBuildContext());
    registerFallbackValue(MockConfig());
  });

  group(
    '$Workbench',
    () {
      testWidgets(
        'given a home widget, '
        'then it is displayed when no use case is selected',
        (tester) async {
          final state = WidgetbookState(
            config: const Config(
              home: Placeholder(),
            ),
          );

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const Workbench(),
          );

          expect(
            find.byType(Placeholder),
            findsOne,
          );
        },
      );

      testWidgets(
        'given a home widget, '
        'then it is not displayed when a use case is selected',
        (tester) async {
          final story = MockStory();
          when(() => story.name).thenReturn('story');
          when(() => story.path).thenReturn('component/story');
          when(() => story.allScenarios(any())).thenReturn([]);
          when(
            () => story.buildWithConfig(any(), any()),
          ).thenReturn(Text(story.name));

          final component = Component<Widget, MockStoryArgs>(
            name: 'component',
            stories: [story],
          );

          final state = WidgetbookState(
            path: 'component/story',
            config: Config(
              home: const Placeholder(),
              components: [component],
            ),
          );

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const Workbench(),
          );

          await tester.pumpAndSettle();

          expect(
            find.byType(Placeholder),
            findsNothing,
          );

          expect(
            find.text(story.name),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'rebuilds story preview when navigating between leaves via '
        '`WidgetbookState.updatePath`',
        (tester) async {
          final storyButton = MockStory();
          final storyCounter = MockStory();
          final buttonArgs = MockStoryArgs();
          final counterArgs = MockStoryArgs();

          var counterCalls = 0;

          when(() => storyButton.args).thenReturn(buttonArgs);
          when(() => storyCounter.args).thenReturn(counterArgs);
          when(() => buttonArgs.safeList).thenReturn([]);
          when(() => counterArgs.safeList).thenReturn([]);

          when(() => storyButton.name).thenReturn('Default');
          when(() => storyButton.path).thenReturn('widgets/Button/Default');
          when(() => storyButton.allScenarios(any())).thenReturn([]);
          when(
            () => storyButton.buildWithConfig(any(), any()),
          ).thenReturn(const Text('StoryButton'));

          when(() => storyCounter.name).thenReturn('Default');
          when(() => storyCounter.path).thenReturn('widgets/Counter/Default');
          when(() => storyCounter.allScenarios(any())).thenReturn([]);
          when(() => storyCounter.buildWithConfig(any(), any())).thenAnswer((
            _,
          ) {
            counterCalls++;
            return const Text('StoryCounter');
          });

          final componentButton = Component<Widget, MockStoryArgs>(
            path: 'widgets',
            name: 'Button',
            stories: [storyButton],
          );
          final componentCounter = Component<Widget, MockStoryArgs>(
            path: 'widgets',
            name: 'Counter',
            stories: [storyCounter],
          );

          final state = WidgetbookState(
            path: 'widgets/Button/Default',
            config: Config(
              home: const Placeholder(),
              components: [componentButton, componentCounter],
            ),
          );

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const Workbench(),
          );

          await tester.pumpAndSettle();

          expect(find.text('StoryButton'), findsOneWidget);
          expect(find.text('StoryCounter'), findsNothing);
          expect(counterCalls, 0);

          state.updatePath('widgets/Counter/Default');

          await tester.pump();
          await tester.pumpAndSettle();

          expect(find.text('StoryCounter'), findsOneWidget);
          expect(find.text('StoryButton'), findsNothing);
          expect(counterCalls, greaterThan(0));
        },
      );
    },
  );
}
