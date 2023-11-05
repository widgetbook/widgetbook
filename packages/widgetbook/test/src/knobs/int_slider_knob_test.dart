import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$IntSliderKnob',
    () {
      testWidgets(
        'given an initial value, '
        'then the value should be displayed',
        (tester) async {
          const value = 5;

          await tester.pumpKnob(
            (context) => Text(
              context.knobs.int
                  .slider(
                    label: 'IntKnob',
                    initialValue: value,
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
          const max = 10;
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.int
                  .slider(
                    label: 'IntKnob',
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

  group('${IntSliderKnob.nullable}', () {
    test('IntSliderKnob.nullable constructor sets correct values', () {
      final knob = IntSliderKnob.nullable(
        label: 'Test Int',
        initialValue: 5,
        description: 'A test int knob',
      );

      expect(knob.label, 'Test Int');
      expect(knob.initialValue, 5);
      expect(knob.description, 'A test int knob');
    });

    test('IntSliderKnob.nullable constructor handles null value', () {
      final knob = IntSliderKnob.nullable(
        label: 'Test Int',
        initialValue: null,
        description: 'A test int knob with null value',
      );

      expect(knob.label, 'Test Int');
      expect(knob.initialValue, null);
      expect(knob.description, 'A test int knob with null value');
    });
  });
}
