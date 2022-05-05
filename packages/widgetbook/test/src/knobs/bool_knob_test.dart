import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/bool_knob.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/widget_test_helper.dart';
import 'knobs_test.dart';

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
      await tester.pumpWidgetWithMaterialApp(
        renderWithKnobs(
            build: (context) => [
                  Text(context.knobs.boolean(
                    label: 'label',
                    initialValue: true,
                  )
                      ? 'Hi'
                      : 'Bye')
                ]),
      );
      expect(find.text('Hi'), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('label-switchTileKnob')));
      await tester.pumpAndSettle();
      expect(find.text('Bye'), findsOneWidget);
    },
  );
}
