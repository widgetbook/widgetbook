import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

// Regression for the preview not reflecting a knob change. Shares the root
// cause with `story_switch_test`: an active [ViewportAddon] places the use case
// inside the `Viewport`'s nested `Navigator`, which used to pin the child and
// ignore later rebuilds — whether triggered by navigation or a knob change.

class _LabelArgs extends StoryArgs<Widget> {
  _LabelArgs() : labelArg = StringArg('A', name: 'label');

  final StringArg labelArg;

  String get label => labelArg.value;

  @override
  List<Arg?> get list => [labelArg];
}

class _KnobStory extends Story<Widget, _LabelArgs> {
  _KnobStory({required super.name, required super.args})
    : super(
        builder: (context, a) => Text(a.label),
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
  group(
    'Knob changes rebuild the workbench preview',
    () {
      testWidgets(
        'when a knob value changes, '
        'then the preview reflects the new knob value',
        (tester) async {
          final args = _LabelArgs();
          final story = _KnobStory(name: 'Default', args: args);

          // Creating the component wires `story.component`, so `story.path`
          // resolves below.
          final component = Component<Widget, _LabelArgs>(
            path: 'widgets',
            name: 'Button',
            stories: [story],
          );

          final state = WidgetbookState(
            path: story.path,
            config: Config(
              home: const Placeholder(),
              addons: [
                ViewportAddon([_viewport]),
              ],
              components: [component],
            ),
          );

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const Workbench(),
          );
          await tester.pumpAndSettle();

          expect(find.text('A'), findsOneWidget);
          expect(find.text('B'), findsNothing);

          state.updateQueryGroup(
            args.labelArg.groupName,
            args.labelArg.valueToQueryGroup('B'),
          );
          await tester.pumpAndSettle();

          expect(find.text('B'), findsOneWidget);
          expect(find.text('A'), findsNothing);
        },
      );
    },
  );
}
