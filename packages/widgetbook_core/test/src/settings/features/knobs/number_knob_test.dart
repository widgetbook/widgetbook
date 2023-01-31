import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../../helper/callback_mock.dart';
import '../../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$NumberKnob',
    () {
      testWidgets(
        'invokes onChanged',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<num>();
          await tester.pumpWidgetWithMaterial(
            child: NumberKnob(
              name: '$NumberKnob',
              value: 10,
              onChanged: valueChangedCallbackMock,
            ),
          );

          final widgetFinder = find.byType(TextField);

          await tester.enterText(widgetFinder, '12');
          await tester.pumpAndSettle();

          verify(() => valueChangedCallbackMock.call(12)).called(1);
        },
      );
    },
  );

  group(
    '$NullableNumberKnob',
    () {
      testWidgets(
        'invokes onChanged',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<num?>();
          await tester.pumpWidgetWithMaterial(
            child: NullableNumberKnob(
              name: '$NullableNumberKnob',
              value: 10,
              onChanged: valueChangedCallbackMock,
            ),
          );

          final widgetFinder = find.byType(TextField);

          await tester.enterText(widgetFinder, '12');
          await tester.pumpAndSettle();

          verify(() => valueChangedCallbackMock.call(12)).called(1);
        },
      );

      testWidgets(
        'invokes onChanged when value changed',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<num?>();
          await tester.pumpWidgetWithMaterial(
            child: NullableNumberKnob(
              name: '$NullableNumberKnob',
              value: 10,
              onChanged: valueChangedCallbackMock,
            ),
          );

          final widgetFinder = find.byType(TextField);

          await tester.enterText(widgetFinder, '12');
          await tester.pumpAndSettle();

          verify(() => valueChangedCallbackMock.call(12)).called(1);
        },
      );

      testWidgets(
        'invokes onChanged when value changes to null',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<num?>();
          await tester.pumpWidgetWithMaterial(
            child: NullableNumberKnob(
              name: '$NullableNumberKnob',
              value: 10,
              onChanged: valueChangedCallbackMock,
            ),
          );

          final widgetFinder = find.byType(Switch).first;

          await tester.tap(widgetFinder);
          await tester.pumpAndSettle();

          verify(() => valueChangedCallbackMock.call(null)).called(1);
        },
      );
    },
  );
}
