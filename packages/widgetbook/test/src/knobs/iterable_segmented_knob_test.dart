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
    '$IterableSegmentedKnob',
    () {
      testWidgets(
        'given no initial value, '
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.iterableOrNull
                  .segmented(
                    label: 'Knob',
                    options: {'A', 'B', 'C'},
                  )
                  .toString(),
            ),
          );

          expect(findSegmentedWithSelected({'A'}), findsNothing);

          await tester.findAndTap(find.text('A'));
          expect(findSegmentedWithSelected({'A'}), findsOneWidget);

          await tester.findAndTap(find.text('A'));
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
              context.knobs.iterable
                  .segmented(
                    label: 'Knob',
                    options: {'A', 'B', 'C'},
                    initialOption: {value},
                  )
                  .toString(),
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
          const key = Key('test');
          await tester.pumpKnob(
            (context) => Text(
              key: key,
              context.knobs.iterable
                  .segmented<String>(
                    label: 'Knob',
                    options: {'A', 'B', 'C'},
                    initialOption: {},
                  )
                  .toString(),
            ),
          );

          await tester.findAndTap(find.text('C'));
          final textWidget = tester.widget<Text>(find.byKey(key));

          expect(textWidget.data, equals('(C)'));
        },
      );
    },
  );

  group(
    '$IterableSegmentedKnob.nullable',
    () {
      testWidgets(
        'when no initial value is provided, '
        'then a null value is returned',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.iterableOrNull
                  .segmented(
                    label: 'Knob',
                    options: {'A', 'B', 'C'},
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
          const key = Key('test');
          await tester.pumpKnob(
            (context) => Text(
              key: key,
              context.knobs.iterableOrNull
                  .segmented(
                    label: 'Knob',
                    options: {'A', 'B', 'C'},
                    initialOption: {'A'},
                  )
                  .toString(),
            ),
          );

          await tester.findAndTap(find.text('C'));
          final textWidget = tester.widget<Text>(find.byKey(key));

          expect(textWidget.data, equals('(A, C)'));
        },
      );

      testWidgets(
        'when nullability is changed twice, '
        'then the value should remain the same as before',
        (tester) async {
          const key = Key('test');
          await tester.pumpKnob(
            (context) => Text(
              key: key,
              context.knobs.iterableOrNull
                  .segmented(
                    label: 'Knob',
                    options: {'A', 'B', 'C'},
                    initialOption: {'A'},
                  )
                  .toString(),
            ),
          );

          await tester.findAndTap(find.text('C'));
          expect(
            findSegmentedWithSelected({'A', 'C'}),
            findsOneWidget,
          );

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget('null'), findsOneWidget);
          expect(
            findSegmentedWithSelected({}),
            findsOneWidget,
          );

          await tester.findAndTap(find.text('C'));
          expect(
            findSegmentedWithSelected({'C'}),
            findsOneWidget,
          );
        },
      );
    },
  );
}
