import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$BooleanKnob',
    () {
      testWidgets(
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs
                  .boolean(
                    label: 'Knob',
                  )
                  .toString(),
            ),
          );

          expect(find.text('false'), findsOneWidget);

          await tester.findAndTap(find.byType(Switch));

          expect(find.text('true'), findsOneWidget);
        },
      );
    },
  );

  group(
    '$BooleanKnob.nullable',
    () {
      testWidgets(
        'given no initial value, '
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs
                  .booleanOrNull(
                    label: 'Knob',
                  )
                  .toString(),
            ),
          );

          expect(find.text('false'), findsNothing);
          expect(find.text('true'), findsNothing);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.text('true'), findsOneWidget);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.text('null'), findsOneWidget);
        },
      );

      testWidgets(
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs
                  .booleanOrNull(
                    label: 'Knob',
                    initialValue: false,
                  )
                  .toString(),
            ),
          );

          expect(find.text('false'), findsOneWidget);

          await tester.findAndTap(find.byType(Switch));
          expect(find.text('true'), findsOneWidget);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.text('null'), findsOneWidget);
        },
      );

      testWidgets(
        'when nullability is changed twice, '
        'then the value should remain the same as before',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs
                  .booleanOrNull(
                    label: 'Knob',
                    initialValue: false,
                  )
                  .toString(),
            ),
          );

          expect(find.text('false'), findsOneWidget);

          await tester.findAndTap(find.byType(Switch));
          expect(find.text('true'), findsOneWidget);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.text('null'), findsOneWidget);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.text('true'), findsOneWidget);
        },
      );
    },
  );
}
