import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$ZoomControlField',
    () {
      final field = ZoomControlField(
        name: 'zoom_control_field',
        initialValue: 1.0,
      );

      test(
        'given a value, '
        'when [codec.toParam] is called, '
        'then it returns the value as a string',
        () {
          final result = field.codec.toParam(1.5);
          expect(result, equals('1.5'));
        },
      );

      test(
        'given a string param, '
        'when [codec.toValue] is called, '
        'then it returns the actual value',
        () {
          final result = field.codec.toValue('1.5');
          expect(result, equals(1.5));
        },
      );

      testWidgets(
        'given a state that has no field value, '
        'then [toWidget] builds the initial value',
        (tester) async {
          final widget = await tester.pumpField<double, Row>(
            field,
            null,
          );

          final textWidget = find.descendant(
            of: find.byWidget(widget),
            matching: find.byType(Text),
          );

          expect(textWidget, findsOneWidget);
          expect((tester.widget(textWidget) as Text).data, equals('1.0x'));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'then [toWidget] builds that value',
        (tester) async {
          final widget = await tester.pumpField<double, Row>(
            field,
            1.5,
          );

          final textWidget = find.descendant(
            of: find.byWidget(widget),
            matching: find.byType(Text),
          );

          expect(textWidget, findsOneWidget);
          expect((tester.widget(textWidget) as Text).data, equals('1.5x'));
        },
      );

      testWidgets(
        'given a zoom value of 1.0, '
        'when zoom out button is pressed, '
        'then zoom value decreases by 0.1',
        (tester) async {
          await tester.pumpField<double, Row>(
            field,
            1.0,
          );

          // Tap the zoom out button
          await tester.tap(find.byIcon(Icons.zoom_out));
          await tester.pump();

          final textWidget = find.byType(Text);
          expect(textWidget, findsOneWidget);
          expect((tester.widget(textWidget) as Text).data, equals('0.9x'));
        },
      );

      testWidgets(
        'given a zoom value of 1.0, '
        'when zoom in button is pressed, '
        'then zoom value increases by 0.1',
        (tester) async {
          await tester.pumpField<double, Row>(
            field,
            1.0,
          );

          // Tap the zoom in button
          await tester.tap(find.byIcon(Icons.zoom_in));
          await tester.pump();

          final textWidget = find.byType(Text);
          expect(textWidget, findsOneWidget);
          expect((tester.widget(textWidget) as Text).data, equals('1.1x'));
        },
      );

      testWidgets(
        'given a zoom value of 1.5, '
        'when reset zoom button is pressed, '
        'then zoom value resets to 1.0',
        (tester) async {
          await tester.pumpField<double, Row>(
            field,
            1.5,
          );

          // Tap the reset zoom button
          await tester.tap(find.byIcon(Icons.refresh));
          await tester.pump();

          final textWidget = find.byType(Text);
          expect(textWidget, findsOneWidget);
          expect((tester.widget(textWidget) as Text).data, equals('1.0x'));
        },
      );
    },
  );
}
