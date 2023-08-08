import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$DoubleInputKnob',
    () {
      testWidgets(
        'given an initial value, '
        'then the value should be displayed',
        (tester) async {
          const value = 5.0;

          await tester.pumpKnob(
            (context) => Text(
              context.knobs.double
                  .input(
                    label: 'Knob',
                    initialValue: value,
                  )
                  .toString(),
            ),
          );

          expect(find.textWidget('$value'), findsOneWidget);
        },
      );

      testWidgets(
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.double
                  .input(
                    label: 'Knob',
                  )
                  .toString(),
            ),
          );

          const text = '7.0';
          await tester.findAndEnter(
            find.byType(TextField),
            text,
          );

          expect(find.textWidget(text), findsOneWidget);
        },
      );
    },
  );
}
