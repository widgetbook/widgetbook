import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import 'knob_helper.dart';

void main() {
  testWidgets(
    'Equality operator works correctly',
    (tester) async {
      final first = BooleanKnob(label: 'first', value: true);
      final second = BooleanKnob(label: 'second', value: true);
      expect(first, equals(BooleanKnob(label: 'first', value: true)));
      expect(first, isNot(equals(second)));
    },
  );

  testWidgets(
    'Bool knob functions',
    (tester) async {
      await tester.pumpWithKnob(
        (context) => Text(
          context.knobs.boolean(
            label: 'label',
          )
              ? 'Hi'
              : 'Bye',
        ),
      );

      expect(find.text('Bye'), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(find.text('Hi'), findsOneWidget);
    },
  );
}
