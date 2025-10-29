import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(MockBuildContext());
  });

  group(
    '$Workbench',
    () {
      testWidgets(
        'given a home widget, '
        'then it is displayed when no use case is selected',
        (tester) async {
          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            home: const Placeholder(),
            components: [],
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
          when(() => story.build(any())).thenReturn(Text(story.name));

          final component = Component<Widget, MockStoryArgs>(
            name: 'component',
            stories: [story],
          );

          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            home: const Placeholder(),
            path: 'component/story',
            components: [component],
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
    },
  );
}
