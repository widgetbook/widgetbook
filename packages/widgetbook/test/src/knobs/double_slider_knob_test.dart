import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$DoubleSliderKnob',
    () {
      testWidgets(
        'given an initial value, '
        'then the value should be displayed',
        (tester) async {
          const value = 5.0;

          await tester.pumpKnob(
            (context) => Text(
              context.knobs.double
                  .slider(
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
          const max = 10.0;
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.double
                  .slider(
                    label: 'Knob',
                    divisions: 1,
                    max: max,
                  )
                  .toString(),
            ),
          );

          await tester.findAndDrag(
            find.byType(Slider),
            const Offset(100, 0),
          );

          expect(find.textWidget('$max'), findsOneWidget);
        },
      );
    },
  );
}
