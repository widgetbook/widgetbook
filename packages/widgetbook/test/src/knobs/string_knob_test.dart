import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$StringKnob',
    () {
      testWidgets(
        'given no initial value, '
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.stringOrNull(label: 'Knob').toString(),
            ),
          );

          expect(find.textWidget(''), findsNothing);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget(''), findsOneWidget);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget(''), findsNothing);
        },
      );

      testWidgets(
        'given an initial value, '
        'then the value should be displayed',
        (tester) async {
          const value = 'Widgetbook';

          await tester.pumpKnob(
            (context) => Text(
              context.knobs.string(
                label: 'Knob',
                initialValue: value,
              ),
            ),
          );

          expect(find.textWidget(value), findsOneWidget);
        },
      );

      testWidgets(
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.string(
                label: 'Knob',
              ),
            ),
          );

          const text = 'Flutter';
          await tester.findAndEnter(find.byType(TextField), text);

          expect(find.textWidget(text), findsOneWidget);
        },
      );
    },
  );

  group(
    '$StringKnob.nullable',
    () {
      testWidgets(
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs
                  .stringOrNull(
                    label: 'Knob',
                  )
                  .toString(),
            ),
          );

          expect(find.textWidget('null'), findsOneWidget);

          final text = 'Widgetbook';
          await tester.findAndEnter(
            find.byType(TextField),
            text,
          );

          expect(find.textWidget(text), findsOneWidget);
        },
      );

      testWidgets(
        'when nullability is changed twice, '
        'then the value should remain the same as before',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs
                  .stringOrNull(
                    label: 'Knob',
                  )
                  .toString(),
            ),
          );

          expect(find.textWidget('null'), findsOneWidget);

          const text = 'Flutter';
          await tester.findAndEnter(
            find.byType(TextField),
            text,
          );

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget('null'), findsOneWidget);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget(text), findsOneWidget);
        },
      );
    },
  );
}
