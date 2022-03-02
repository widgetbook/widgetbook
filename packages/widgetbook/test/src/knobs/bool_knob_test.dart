import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/bool_knob.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/knobs/nullable_bool_knob.dart';

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
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('label-switchTileKnob')));
      await tester.pumpAndSettle();
      expect(find.text('Bye'), findsOneWidget);
    },
  );

  testWidgets(
    'Equality operator works correctly',
    (WidgetTester tester) async {
      final first = NullableBoolKnob(label: 'first', value: null);
      final second = NullableBoolKnob(label: 'second', value: null);
      expect(first, equals(NullableBoolKnob(label: 'first', value: null)));
      expect(first, isNot(equals(second)));
    },
  );

  testWidgets(
    'Nullable Bool knob functions',
    (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterialApp(
        renderWithKnobs(build: (context) {
          final value = context.knobs.nullableBoolean(
            label: 'label',
            initialValue: null,
          );
          String text;

          switch (value) {
            case null:
              text = 'idk';
              break;
            case true:
              text = 'hi';
              break;
            case false:
              text = 'bye';
              break;
            default:
              text = 'wont happen';
          }
          return [Text(text)];
        }),
      );

      expect(find.text('idk'), findsOneWidget);
      await tester.tap(find.byKey(const Key('label-switchTileKnob-check')));
      await tester.pumpAndSettle();

      expect(find.text('bye'), findsOneWidget);
      await tester.tap(find.byKey(const Key('label-switchTileKnob')));
      await tester.pumpAndSettle();

      expect(find.text('hi'), findsOneWidget);
      await tester.tap(find.byKey(const Key('label-switchTileKnob-check')));
      await tester.pumpAndSettle();

      expect(find.text('idk'), findsOneWidget);
      await tester.pumpAndSettle();
    },
  );
}
