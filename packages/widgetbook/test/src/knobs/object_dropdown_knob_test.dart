import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$ObjectDropdownKnob',
    () {
      testWidgets(
        'given no initial value, '
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.objectOrNull
                  .dropdown(
                    label: 'Knob',
                    options: ['A', 'B', 'C'],
                  )
                  .toString(),
            ),
          );

          expect(find.textWidget('A'), findsNothing);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget('A'), findsOneWidget);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget('A'), findsNothing);
        },
      );

      testWidgets(
        'given an initial value, '
        'then the value should be displayed',
        (tester) async {
          const value = 'B';

          await tester.pumpKnob(
            (context) => Text(
              context.knobs.object.dropdown(
                label: 'Knob',
                options: ['A', 'B', 'C'],
                initialOption: value,
              ),
            ),
          );

          expect(
            find.textWidget(value),
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
              context.knobs.object.dropdown(
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
            findsOneWidget,
          );
        },
      );
    },
  );

  group(
    '$ObjectDropdownKnob.nullable',
    () {
      testWidgets(
        'when no initial value is provided, '
        'then a null value is returned',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.objectOrNull
                  .dropdown(
                    label: 'Knob',
                    options: ['A', 'B', 'C'],
                  )
                  .toString(),
            ),
          );

          final menu = tester.widget<DropdownMenu<String>>(
            find.byType(DropdownMenu<String>),
          );

          // DropdownMenu has no initialSelection as
          // no initial value is provided
          expect(
            menu.initialSelection,
            isNull,
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
                  .dropdown(
                    label: 'Knob',
                    options: ['A', 'B', 'C'],
                    initialOption: 'A',
                  )
                  .toString(),
            ),
          );

          const value = 'C';
          await tester.findAndTap(find.byType(DropdownMenu<String>));
          await tester.findAndTap(find.text(value).last);

          expect(
            find.textWidget(value),
            findsOneWidget,
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
                  .dropdown(
                    label: 'Knob',
                    options: ['A', 'B', 'C'],
                    initialOption: 'A',
                  )
                  .toString(),
            ),
          );

          const value = 'C';
          await tester.findAndTap(find.byType(DropdownMenu<String>));
          await tester.findAndTap(find.text(value).last);
          expect(
            find.textWidget(value),
            findsOneWidget,
          );

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget('null'), findsOneWidget);

          await tester.findAndTap(find.byType(Checkbox));
          expect(
            find.textWidget(value),
            findsOneWidget,
          );
        },
      );
    },
  );
}
