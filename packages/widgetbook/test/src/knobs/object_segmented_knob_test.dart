import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

Finder findSegmentedWithSelected(Set<String> selected) {
  return find.byWidgetPredicate(
    (widget) =>
        widget is SegmentedButton<String> &&
        setEquals(widget.selected, selected),
  );
}

void main() {
  group(
    '$ObjectSegmentedKnob',
    () {
      testWidgets(
        'given no initial value, '
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.objectOrNull
                  .segmented(
                    label: 'Knob',
                    options: ['A', 'B', 'C'],
                  )
                  .toString(),
            ),
          );

          expect(findSegmentedWithSelected({'A'}), findsNothing);

          await tester.findAndTap(find.byType(Checkbox));
          expect(findSegmentedWithSelected({'A'}), findsOneWidget);

          await tester.findAndTap(find.byType(Checkbox));
          expect(findSegmentedWithSelected({'A'}), findsNothing);
        },
      );

      testWidgets(
        'given an initial value, '
        'then the value should be selected',
        (tester) async {
          const value = 'B';

          await tester.pumpKnob(
            (context) => Text(
              context.knobs.object.segmented(
                label: 'Knob',
                options: ['A', 'B', 'C'],
                initialOption: value,
              ),
            ),
          );

          expect(
            findSegmentedWithSelected({value}),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.object.segmented(
                label: 'Knob',
                options: ['A', 'B', 'C'],
              ),
            ),
          );

          const value = 'C';
          await tester.findAndTap(find.byType(SegmentedButton<String>));
          await tester.findAndTap(find.text(value).last);

          expect(
            find.textWidget(value),
            findsNWidgets(2), // Button and Text widget
          );
        },
      );
    },
  );

  group(
    '$ObjectSegmentedKnob.nullable',
    () {
      testWidgets(
        'when no initial value is provided, '
        'then a null value is returned',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.objectOrNull
                  .segmented(
                    label: 'Knob',
                    options: ['A', 'B', 'C'],
                  )
                  .toString(),
            ),
          );

          expect(
            findSegmentedWithSelected({}),
            findsOneWidget,
          );

          expect(
            find.text('null'),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.objectOrNull
                  .segmented(
                    label: 'Knob',
                    options: ['A', 'B', 'C'],
                    initialOption: 'A',
                  )
                  .toString(),
            ),
          );

          const value = 'C';
          await tester.findAndTap(find.byType(SegmentedButton<String>));
          await tester.findAndTap(find.text(value).last);

          expect(
            find.textWidget(value),
            findsNWidgets(2), // Button and Text widget
          );
        },
      );

      testWidgets(
        'when nullability is changed twice, '
        'then the value should remain the same as before',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.objectOrNull
                  .segmented(
                    label: 'Knob',
                    options: ['A', 'B', 'C'],
                    initialOption: 'A',
                  )
                  .toString(),
            ),
          );

          const value = 'C';
          await tester.findAndTap(find.byType(SegmentedButton<String>));
          await tester.findAndTap(find.text(value).last);
          expect(
            findSegmentedWithSelected({value}),
            findsOneWidget,
          );

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget('null'), findsOneWidget);
          expect(
            findSegmentedWithSelected({}),
            findsOneWidget,
          );

          await tester.findAndTap(find.byType(Checkbox));
          expect(
            findSegmentedWithSelected({value}),
            findsOneWidget,
          );
        },
      );
    },
  );
}
