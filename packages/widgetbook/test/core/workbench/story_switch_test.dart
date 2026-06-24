import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/routing/routing.dart';
import 'package:widgetbook/src/core/state/state.dart';
import 'package:widgetbook/src/core/theme/theme.dart';
import 'package:widgetbook/src/core/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

// Regression for the preview staying stuck on the previous story when switching
// between stories. An active [ViewportAddon] is required: it places the use case
// inside the `Viewport`'s nested `Navigator`, where it used to get pinned.
// The knob-change variant of the same root cause lives in `knob_rebuild_test`.

class _NoArgs extends StoryArgs<Widget> {
  const _NoArgs();

  @override
  List<Arg?> get list => const [];
}

class _TextStory extends Story<Widget, _NoArgs> {
  _TextStory({
    required super.name,
    required String label,
  }) : super(
         args: const _NoArgs(),
         builder: (context, args) => Text(label),
       );
}

const _viewport = ViewportData(
  name: 'Square',
  width: 480,
  height: 480,
  pixelRatio: 2.0,
  platform: TargetPlatform.android,
);

void main() {
  Config buildConfig({
    required _TextStory buttonStory,
    required _TextStory counterStory,
  }) {
    return Config(
      home: const Placeholder(),
      addons: [
        ViewportAddon([_viewport]),
      ],
      components: [
        Component<Widget, _NoArgs>(
          path: 'widgets',
          name: 'Button',
          stories: [buttonStory],
        ),
        Component<Widget, _NoArgs>(
          path: 'widgets',
          name: 'Counter',
          stories: [counterStory],
        ),
      ],
    );
  }

  group(
    'Story navigation rebuilds the workbench preview',
    () {
      testWidgets(
        'when `updatePath` switches from one story to another, '
        'then the preview shows the newly selected story',
        (tester) async {
          final buttonStory = _TextStory(name: 'Default', label: 'ButtonStory');
          final counterStory = _TextStory(
            name: 'Default',
            label: 'CounterStory',
          );

          // Build the config first so `Component` wires up `story.component`
          // before we read `story.path`.
          final config = buildConfig(
            buttonStory: buttonStory,
            counterStory: counterStory,
          );
          final state = WidgetbookState(
            path: buttonStory.path,
            config: config,
          );

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const Workbench(),
          );
          await tester.pumpAndSettle();

          expect(find.text('ButtonStory'), findsOneWidget);
          expect(find.text('CounterStory'), findsNothing);

          state.updatePath(counterStory.path);
          await tester.pumpAndSettle();

          expect(find.text('CounterStory'), findsOneWidget);
          expect(find.text('ButtonStory'), findsNothing);
        },
      );

      // Pumped through the full production stack: `MaterialApp.router` ->
      // `AppRouterDelegate` -> `ResponsiveLayout` -> `Workbench`.
      testWidgets(
        'given the full router stack, '
        'when navigating between two story leaves, '
        'then the workbench preview reflects the new story',
        (tester) async {
          final buttonStory = _TextStory(name: 'Default', label: 'ButtonStory');
          final counterStory = _TextStory(
            name: 'Default',
            label: 'CounterStory',
          );

          final config = buildConfig(
            buttonStory: buttonStory,
            counterStory: counterStory,
          );

          final state = WidgetbookState(config: config);
          final router = AppRouter(state: state, uri: Uri.parse('/'));

          await tester.pumpWidget(
            WidgetbookTheme(
              data: Themes.dark,
              child: WidgetbookScope(
                state: state,
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  routerConfig: router,
                ),
              ),
            ),
          );

          state.updatePath(buttonStory.path);
          await tester.pumpAndSettle();
          expect(find.text('ButtonStory'), findsOneWidget);
          expect(find.text('CounterStory'), findsNothing);

          state.updatePath(counterStory.path);
          await tester.pumpAndSettle();

          expect(find.text('CounterStory'), findsOneWidget);
          expect(find.text('ButtonStory'), findsNothing);
        },
      );
    },
  );
}
