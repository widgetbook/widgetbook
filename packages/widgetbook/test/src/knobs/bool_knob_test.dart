import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/bool_knob.dart';
import 'package:widgetbook/src/knobs/knobs_notifier.dart';

import 'knob_helper.dart';

void main() {
  testWidgets(
    'Equality operator works correctly',
    (WidgetTester tester) async {
      final first = BoolKnob(label: 'first', value: true);
      final second = BoolKnob(label: 'second', value: true);
      expect(first, equals(BoolKnob(label: 'first', value: true)));
      expect(first, isNot(equals(second)));
    },
  );

  testWidgets(
    'Bool knob functions',
    (WidgetTester tester) async {
      await tester.pumpWithKnob(
        (context) => Text(
          context.knobs.boolean(
            label: 'label',
            initialValue: true,
          )
              ? 'Hi'
              : 'Bye',
        ),
      );

      expect(find.text('Hi'), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(Switch).first);
      await tester.pumpAndSettle();

      expect(find.text('Bye'), findsOneWidget);
    },
  );
}
