import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../../helper/callback_mock.dart';
import '../../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$BoolKnob',
    () {
      testWidgets(
        'invokes onChanged',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<bool>();
          await tester.pumpWidgetWithMaterial(
            child: BoolKnob(
              name: '$BoolKnob',
              value: true,
              onChanged: valueChangedCallbackMock,
            ),
          );

          final widgetFinder = find.byType(Switch);

          await tester.tap(widgetFinder);
          await tester.pumpAndSettle();

          verify(() => valueChangedCallbackMock.call(false)).called(1);
        },
      );
    },
  );

  group(
    '$NullableBoolKnob',
    () {
      testWidgets(
        'invokes onChanged when value changes',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<bool?>();
          await tester.pumpWidgetWithMaterial(
            child: NullableBoolKnob(
              name: '$NullableBoolKnob',
              value: true,
              onChanged: valueChangedCallbackMock,
            ),
          );

          // Bit hacky
          // There are two Switches
          //   - one for setting the value to null
          //   - one for switching the non-null value
          //     (if the first switch is on)
          final widgetFinder = find.byType(Switch).last;

          await tester.tap(widgetFinder);
          await tester.pumpAndSettle();

          verify(() => valueChangedCallbackMock.call(false)).called(1);
        },
      );

      testWidgets(
        'invokes onChanged when value changes to null',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<bool?>();
          await tester.pumpWidgetWithMaterial(
            child: NullableBoolKnob(
              name: '$NullableBoolKnob',
              value: true,
              onChanged: valueChangedCallbackMock,
            ),
          );

          // Bit hacky
          // There are two Switches
          //   - one for setting the value to null
          //   - one for switching the non-null value
          //     (if the first switch is on)
          final widgetFinder = find.byType(Switch).first;

          await tester.tap(widgetFinder);
          await tester.pumpAndSettle();

          verify(() => valueChangedCallbackMock.call(null)).called(1);
        },
      );
    },
  );
}
