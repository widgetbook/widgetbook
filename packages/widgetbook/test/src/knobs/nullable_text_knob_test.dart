import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/knobs/text_knob.dart';

import '../../helper/widget_test_helper.dart';
import 'knobs_test.dart';

void main() {
  const value1 = 'Value 1';
  const value2 = 'Value 2';
  testWidgets(
    'Equality operator works correctly',
    (WidgetTester tester) async {
      final first = NullableTextKnob(
        label: 'first',
        value: null,
      );
      final second = NullableTextKnob(
        label: 'second',
        value: 'value',
      );
      expect(
        first,
        equals(
          NullableTextKnob(
            label: 'first',
            value: null,
          ),
        ),
      );
      expect(first, isNot(equals(second)));
    },
  );

  testWidgets(
    'Nullable String knob functions',
    (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterialApp(
        renderWithKnobs(
          build: (context) {
            final value = context.knobs.nullableText(
              label: 'label',
            );

            final text = value ?? value2;

            return [Text(text)];
          },
        ),
      );

      expect(find.text(value2), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField),
        value1,
      );

      await tester.pumpAndSettle();
      expect(find.text(value1), findsWidgets);
      expect(find.text(value2), findsNothing);
    },
  );

  testWidgets(
    'Nullable String remembers previosu value',
    (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterialApp(
        renderWithKnobs(
          build: (context) {
            final value = context.knobs.nullableText(
              label: 'label',
            );

            final text = value ?? value2;

            return [Text(text)];
          },
        ),
      );

      expect(find.text(value2), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField),
        value1,
      );
      await tester.pumpAndSettle();
      expect(find.text(value1), findsWidgets);
      expect(find.text(value2), findsNothing);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(find.text(value1), findsWidgets);
    },
  );
}
