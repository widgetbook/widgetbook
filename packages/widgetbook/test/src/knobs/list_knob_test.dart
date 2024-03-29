import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$ListKnob',
    () {
      testWidgets(
        'given an initial value, '
        'then the value should be displayed',
        (tester) async {
          const value = 'B';

          await tester.pumpKnob(
            (context) => Text(
              context.knobs.list(
                label: 'Knob',
                options: ['A', 'B', 'C'],
                initialOption: value,
              ),
            ),
          );

          expect(
            find.textWidget(value),
            findsNWidgets(2),
          );
        },
      );

      testWidgets(
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.list(
                label: 'Knob',
                options: ['A', 'B', 'C'],
              ),
            ),
          );

          const value = 'C';
          await tester.findAndTap(find.byType(DropdownMenu<String>));
          await tester.findAndTap(find.text(value).last);

          expect(
            find.textWidget(value),
            findsNWidgets(2),
          );
        },
      );
    },
  );

  group(
    '$ListKnob.nullable',
    () {
      testWidgets(
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.listOrNull(
                label: 'Knob',
                options: ['A', 'B', 'C'],
              ).toString(),
            ),
          );

          const value = 'C';
          await tester.findAndTap(find.byType(DropdownMenu<String?>));
          await tester.findAndTap(find.text(value).last);

          expect(
            find.textWidget(value),
            findsNWidgets(2),
          );
        },
      );

      testWidgets(
        'when nullability is changed twice, '
        'then the value should remain the same as before',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.listOrNull(
                label: 'Knob',
                options: ['A', 'B', 'C'],
              ).toString(),
            ),
          );

          expect(
            find.textWidget('A'),
            findsNWidgets(2),
          );

          const value = 'C';
          await tester.findAndTap(find.byType(DropdownMenu<String?>));
          await tester.findAndTap(find.text(value).last);
          expect(
            find.textWidget(value),
            findsNWidgets(2),
          );

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget('null'), findsOneWidget);

          await tester.findAndTap(find.byType(Checkbox));
          expect(
            find.textWidget(value),
            findsNWidgets(2),
          );
        },
      );
    },
  );
}
