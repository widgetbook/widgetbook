import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import 'knob_helper.dart';

void main() {
  testWidgets(
    'Equality operator works correctly',
    (tester) async {
      final first = BooleanOrNullKnob(label: 'first', value: null);
      final second = BooleanOrNullKnob(label: 'second', value: null);
      expect(first, equals(BooleanOrNullKnob(label: 'first', value: null)));
      expect(first, isNot(equals(second)));
    },
  );

  testWidgets(
    'Nullable Bool knob functions',
    (tester) async {
      await tester.pumpWithKnob(
        (context) {
          final value = context.knobs.booleanOrNull(
            label: 'label',
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

          return Text(text);
        },
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(find.text('bye'), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(find.text('hi'), findsOneWidget);

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(find.text('idk'), findsOneWidget);
    },
  );

  testWidgets(
    'Nullable Bool knob remembers previous value before null',
    (tester) async {
      await tester.pumpWithKnob(
        (context) {
          final value = context.knobs.booleanOrNull(
            label: 'label',
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

          return Text(text);
        },
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(find.text('bye'), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(find.text('hi'), findsOneWidget);

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(find.text('idk'), findsOneWidget);

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(find.text('hi'), findsOneWidget);
    },
  );
}
