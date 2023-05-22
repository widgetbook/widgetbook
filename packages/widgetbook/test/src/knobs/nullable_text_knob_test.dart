import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import 'knob_helper.dart';

void main() {
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
      final text = 'widgetbook';
      final key = ValueKey(text);

      await tester.pumpWithKnob(
        (context) {
          final value = context.knobs.nullableText(
            label: 'label',
          );

          return value == null
              ? const SizedBox.shrink()
              : Text(
                  key: key,
                  value,
                );
        },
      );

      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField),
        text,
      );

      await tester.pumpAndSettle();
      expect(find.byKey(key), findsWidgets);

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(find.byKey(key), findsNothing);
    },
  );

  testWidgets(
    'Nullable String remembers previous value',
    (WidgetTester tester) async {
      final text = 'widgetbook';
      final key = ValueKey(text);

      await tester.pumpWithKnob(
        (context) {
          final value = context.knobs.nullableText(
            label: 'label',
          );

          return value == null
              ? const SizedBox.shrink()
              : Text(
                  key: key,
                  value,
                );
        },
      );

      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField),
        text,
      );

      await tester.pumpAndSettle();
      expect(find.byKey(key), findsWidgets);

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(find.byKey(key), findsNothing);

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(find.byKey(key), findsWidgets);
    },
  );
}
