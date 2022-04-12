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
      final first = NullableTextKnob(label: 'first', value: null);
      final second = NullableTextKnob(label: 'second', value: 'value');
      expect(first, equals(NullableTextKnob(label: 'first', value: null)));
      expect(first, isNot(equals(second)));
    },
  );

  testWidgets(
    'Nullable String knob functions',
    (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterialApp(
        renderWithKnobs(build: (context) {
          final value = context.knobs.nullableText(
            label: 'label',
          );

          final text = value ?? 'default';

          return [Text(text)];
        }),
      );

      expect(find.text('default'), findsOneWidget);

      await tester.tap(find.byKey(const Key('label-nullableCheckbox')));
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('label-textKnob')), 'awesome');
      await tester.pumpAndSettle();
      expect(find.text('awesome'), findsWidgets);
      expect(find.text('default'), findsNothing);
    },
  );

  testWidgets(
    'Nullable String remembers previosu value',
    (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterialApp(
        renderWithKnobs(build: (context) {
          final value = context.knobs.nullableText(
            label: 'label',
          );

          final text = value ?? 'default';

          return [Text(text)];
        }),
      );

      expect(find.text('default'), findsOneWidget);

      await tester.tap(find.byKey(const Key('label-nullableCheckbox')));
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('label-textKnob')), 'awesome');
      await tester.pumpAndSettle();
      expect(find.text('awesome'), findsWidgets);
      expect(find.text('default'), findsNothing);

      await tester.tap(find.byKey(const Key('label-nullableCheckbox')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('label-nullableCheckbox')));
      await tester.pumpAndSettle();
      expect(find.text('awesome'), findsWidgets);
    },
  );
}
