import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import 'knob_helper.dart';

void main() {
  testWidgets(
    'Equality operator works correctly',
    (tester) async {
      final first = DoubleInputKnob(label: 'first', value: 2);
      final second = DoubleInputKnob(label: 'second', value: 3);

      expect(first, equals(DoubleInputKnob(label: 'first', value: 2)));
      expect(first, isNot(equals(second)));
    },
  );

  testWidgets(
    'Number knob initial value works',
    (tester) async {
      await tester.pumpWithKnob(
        (context) => Text(
          context.knobs.double
              .slider(
                label: 'label',
                initialValue: 5,
              )
              .toString(),
        ),
      );

      expect(find.text('5.0'), findsWidgets);
    },
  );

  testWidgets(
    'Number knob description displays',
    (tester) async {
      await tester.pumpWithKnob(
        (context) => Text(
          context.knobs.double
              .input(
                label: 'label',
                initialValue: 200,
                description: 'test description',
              )
              .toString(),
        ),
      );

      expect(find.text('200.0'), findsWidgets);
    },
  );

  testWidgets(
    'Number knob functions',
    (tester) async {
      await tester.pumpWithKnob(
        (context) => Text(
          context.knobs.double
              .input(
                label: 'label',
              )
              .toString(),
        ),
      );

      await tester.enterText(find.byType(TextField), '5.5');
      await tester.pumpAndSettle();

      expect(find.text('5.5'), findsWidgets);
    },
  );
}
