import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/knobs/text_knob.dart';

import '../../helper/widget_test_helper.dart';
import 'knobs_test.dart';

void main() {
  testWidgets(
    'Equality operator works correctly',
    (WidgetTester tester) async {
      final first = TextKnob(label: 'first', value: 'hello');
      final second = TextKnob(label: 'second', value: 'goodbye');

      expect(first, equals(TextKnob(label: 'first', value: 'hello')));
      expect(first, isNot(equals(second)));
    },
  );

  testWidgets(
    'Text knob initial value works',
    (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterialApp(
        renderWithKnobs(
            build: (context) => [
                  Text(context.knobs.text(
                    label: 'label',
                    initialValue: 'Hi dude',
                  ))
                ]),
      );
      expect(find.text('Hi dude'), findsWidgets);
    },
  );

  testWidgets(
    'Text knob description displays',
    (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterialApp(
        renderWithKnobs(
          build: (context) => [
            Text(
              context.knobs.text(
                  label: 'label',
                  initialValue: 'Hi dude',
                  description: 'test description'),
            )
          ],
        ),
      );
      expect(find.text('test description'), findsOneWidget);
    },
  );

  testWidgets(
    'Text knob functions',
    (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterialApp(
        renderWithKnobs(
            build: (context) => [
                  Text(context.knobs.text(
                    label: 'label',
                  ))
                ]),
      );
      await tester.enterText(find.byKey(const Key('label-textKnob')), 'Bye');
      await tester.pumpAndSettle();

      expect(find.text('Bye'), findsWidgets);
    },
  );
}
