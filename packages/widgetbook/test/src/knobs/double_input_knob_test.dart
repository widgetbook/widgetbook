import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$DoubleInputKnob',
    () {
      testWidgets(
        'given no initial value, '
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(
              context.knobs.doubleOrNull.input(label: 'Knob').toString(),
            ),
          );

          expect(find.textWidget('0.0'), findsNothing);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget('0.0'), findsOneWidget);

          await tester.findAndTap(find.byType(Checkbox));
          expect(find.textWidget('0.0'), findsNothing);
        },
      );

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

  group('${DoubleInputKnob.nullable}', () {
    test('DoubleInputKnob.nullable constructor sets correct values', () {
      final knob = DoubleInputKnob.nullable(
        label: 'Test double',
        initialValue: 5.0,
        description: 'A test double knob',
      );

      expect(knob.label, 'Test double');
      expect(knob.initialValue, 5.0);
      expect(knob.description, 'A test double knob');
    });

    test('DoubleInputKnob.nullable constructor handles null value', () {
      final knob = DoubleInputKnob.nullable(
        label: 'Test double',
        initialValue: null,
        description: 'A test double knob with null value',
      );

      expect(knob.label, 'Test double');
      expect(knob.initialValue, null);
      expect(knob.description, 'A test double knob with null value');
    });
  });

  group('$KnobsBuilder', () {
    double? mockOnKnobAdded<double>(Knob<double?> knob) => knob.initialValue;
    final builder = KnobsBuilder(mockOnKnobAdded);

    test('doubleOrNull sets correct values', () {
      final doubleValue = builder.doubleOrNull.input(
        label: 'Test double',
        initialValue: 10.0,
        description: 'A test double',
      );

      expect(doubleValue, 10.0);
    });

    test('doubleOrNull handles null initialValue', () {
      final doubleValue = builder.doubleOrNull.input(
        label: 'Test double',
        description: 'A test double with null value',
      );

      expect(doubleValue, null);
    });
  });
}
