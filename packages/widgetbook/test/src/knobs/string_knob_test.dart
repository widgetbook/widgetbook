import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import 'knob_helper.dart';

void main() {
  testWidgets(
    'Equality operator works correctly',
    (tester) async {
      final first = StringKnob(
        label: 'first',
        value: 'hello',
      );
      final second = StringKnob(
        label: 'second',
        value: 'goodbye',
      );

      expect(
        first,
        equals(
          StringKnob(
            label: 'first',
            value: 'hello',
          ),
        ),
      );
      expect(first, isNot(equals(second)));
    },
  );

  testWidgets(
    'Text knob initial value works',
    (tester) async {
      await tester.pumpWithKnob(
        (context) => Text(
          context.knobs.string(
            label: 'label',
            initialValue: 'Hi dude',
          ),
        ),
      );

      expect(find.text('Hi dude'), findsWidgets);
    },
  );

  testWidgets(
    'Text knob description displays',
    (tester) async {
      await tester.pumpWithKnob(
        (context) => Text(
          context.knobs.string(
            label: 'label',
            initialValue: 'Hi dude',
            description: 'test description',
          ),
        ),
      );

      expect(find.text('test description'), findsOneWidget);
    },
  );

  testWidgets(
    'Text knob functions',
    (tester) async {
      await tester.pumpWithKnob(
        (context) => Text(
          context.knobs.string(
            label: 'label',
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Bye');
      await tester.pumpAndSettle();

      expect(find.text('Bye'), findsWidgets);
    },
  );
}
