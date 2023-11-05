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
                    divisions: 10,
                  )
                  .toString(),
            ),
          );

          expect(find.textWidget('$value'), findsWidgets);
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

          expect(find.textWidget('$max'), findsWidgets);
        },
      );
    },
  );

  group('${DoubleSliderKnob.nullable}', () {
    test('DoubleSliderKnob.nullable constructor sets correct values', () {
      final knob = DoubleSliderKnob.nullable(
        label: 'Test Int',
        initialValue: 5.0,
        description: 'A test double knob',
      );

      expect(knob.label, 'Test Int');
      expect(knob.initialValue, 5.0);
      expect(knob.description, 'A test double knob');
    });

    test('DoubleSliderKnob.nullable constructor handles null value', () {
      final knob = DoubleSliderKnob.nullable(
        label: 'Test double',
        initialValue: null,
        description: 'A test double knob with null value',
      );

      expect(knob.label, 'Test double');
      expect(knob.initialValue, null);
      expect(knob.description, 'A test double knob with null value');
    });
  });
}
