import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$MultiSelectListKnob',
    () {
      testWidgets(
        'given an initial value, '
        'then the initial selected values should be displayed',
        (tester) async {
          const initialValue = ['B'];

          await tester.pumpKnob(
            (context) => Column(
              children: context.knobs
                  .multiSelectList(
                    label: 'Knob',
                    options: ['A', 'B', 'C'],
                    initialSelection: initialValue,
                  )
                  .map((value) => Text(value))
                  .toList(),
            ),
          );

          expect(
            find.textWidget('B'),
            findsNWidgets(2),
          );
        },
      );

      testWidgets(
        'when a value is selected, '
        'then the value should be displayed in the selected list',
        (tester) async {
          await tester.pumpKnob(
            (context) => Column(
              children: context.knobs
                  .multiSelectList(
                    label: 'Knob',
                    options: ['A', 'B', 'C'],
                  )
                  .map((value) => Text(value))
                  .toList(),
            ),
          );

          const value = 'C';
          await tester.findAndTap(find.text(value));

          expect(
            find.textWidget(value),
            findsNWidgets(2),
          );
        },
      );

      testWidgets(
        'when a value is deselected, '
        'then the value should be removed from the selected list',
        (tester) async {
          await tester.pumpKnob(
            (context) => Column(
              children: context.knobs
                  .multiSelectList(
                    label: 'Knob',
                    options: ['A', 'B', 'C'],
                    initialSelection: ['B', 'C'],
                  )
                  .map((value) => Text(value))
                  .toList(),
            ),
          );

          const value = 'C';
          await tester.findAndTap(find.text(value));

          expect(
            find.textWidget(value),
            findsOneWidget,
          );
        },
      );
    },
  );

  group(
    '$MultiSelectListKnob.nullable',
    () {
      testWidgets(
        'when a value is selected, '
        'then the value should be added to the selected list',
        (tester) async {
          await tester.pumpKnob(
            (context) => Column(
              children: context.knobs
                      .multiSelectListOrNull(
                        label: 'Knob',
                        options: ['A', 'B', 'C'],
                      )
                      ?.map((value) => Text(value))
                      .toList() ??
                  [],
            ),
          );

          const value = 'C';
          await tester.findAndTap(find.text(value));

          expect(
            find.textWidget(value),
            findsNWidgets(2),
          );
        },
      );

      testWidgets(
        'when a value is deselected, '
        'then the value should be removed from the selected list',
        (tester) async {
          await tester.pumpKnob(
            (context) => Column(
              children: context.knobs
                      .multiSelectListOrNull(
                        label: 'Knob',
                        options: ['A', 'B', 'C'],
                        initialSelection: ['B', 'C'],
                      )
                      ?.map((value) => Text(value))
                      .toList() ??
                  [],
            ),
          );

          const value = 'C';
          await tester.findAndTap(find.text(value));

          expect(
            find.textWidget(value),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'when all values are deselected, '
        'then the selection should be empty',
        (tester) async {
          await tester.pumpKnob(
            (context) => Column(
              children: context.knobs
                      .multiSelectListOrNull(
                        label: 'Knob',
                        options: ['A', 'B', 'C'],
                        initialSelection: ['B'],
                      )
                      ?.map((value) => Text(value))
                      .toList() ??
                  [],
            ),
          );

          const value = 'B';
          await tester.findAndTap(find.text(value));

          expect(
            find.textWidget(value),
            findsOneWidget,
          );
        },
      );
    },
  );
}
