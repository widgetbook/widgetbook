import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../../helper/callback_mock.dart';
import '../../../../helper/widget_tester_extension.dart';

void main() {
  const initialValue = 'Value';
  const newValue = 'New Value';
  group(
    '$TextKnob',
    () {
      testWidgets(
        'invokes onChanged',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<String>();
          await tester.pumpWidgetWithMaterial(
            child: TextKnob(
              name: '$TextKnob',
              value: initialValue,
              onChanged: valueChangedCallbackMock,
            ),
          );

          final widgetFinder = find.byType(TextField);

          await tester.enterText(widgetFinder, newValue);
          await tester.pumpAndSettle();

          verify(() => valueChangedCallbackMock.call(newValue)).called(1);
        },
      );
    },
  );

  group(
    '$NullableTextKnob',
    () {
      testWidgets(
        'invokes onChanged',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<String?>();
          await tester.pumpWidgetWithMaterial(
            child: NullableTextKnob(
              name: '$NullableTextKnob',
              value: initialValue,
              onChanged: valueChangedCallbackMock,
            ),
          );

          final widgetFinder = find.byType(TextField);

          await tester.enterText(widgetFinder, newValue);
          await tester.pumpAndSettle();

          verify(() => valueChangedCallbackMock.call(newValue)).called(1);
        },
      );

      testWidgets(
        'invokes onChanged when value changes to null',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<String?>();
          await tester.pumpWidgetWithMaterial(
            child: NullableTextKnob(
              name: '$NullableTextKnob',
              value: initialValue,
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
