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

      await tester.tap(find.byKey(const Key('label-nullableCheckbox')));
      await tester.pumpAndSettle();
      expect(find.text('bye'), findsOneWidget);

      await tester.tap(find.byKey(const Key('label-switchTileKnob')));
      await tester.pumpAndSettle();
      expect(find.text('hi'), findsOneWidget);

      await tester.tap(find.byKey(const Key('label-nullableCheckbox')));
      await tester.pumpAndSettle();
      expect(find.text('idk'), findsOneWidget);

      expect(find.text('idk'), findsOneWidget);
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'Nullable Bool knob remembers previous value before null',
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

      await tester.tap(find.byKey(const Key('label-nullableCheckbox')));
      await tester.pumpAndSettle();
      expect(find.text('bye'), findsOneWidget);

      await tester.tap(find.byKey(const Key('label-switchTileKnob')));
      await tester.pumpAndSettle();
      expect(find.text('hi'), findsOneWidget);

      await tester.tap(find.byKey(const Key('label-nullableCheckbox')));
      await tester.pumpAndSettle();
      expect(find.text('idk'), findsOneWidget);

      await tester.tap(find.byKey(const Key('label-nullableCheckbox')));
      await tester.pumpAndSettle();
      expect(find.text('hi'), findsOneWidget);
    },
  );
}
