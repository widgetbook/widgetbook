import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../../helper/callback_mock.dart';
import '../../../../helper/widget_tester_extension.dart';

extension SlideTo on WidgetTester {
  Future<void> setSliderToValue(
    Finder sliderFinder,
    double value, {
    double paddingOffset = 24.0,
  }) async {
    final slider = sliderFinder.evaluate().single.widget as Slider;
    final zeroPoint = getTopLeft(sliderFinder) +
        Offset(
          paddingOffset,
          getSize(sliderFinder).height / 2,
        );
    final totalWidth = getSize(sliderFinder).width - (2 * paddingOffset);
    final calculatedOffset = totalWidth * value / slider.max;
    await tapAt(zeroPoint + Offset(calculatedOffset, 0));
  }
}

void main() {
  group(
    '$SliderKnob',
    () {
      testWidgets(
        'invokes onChanged',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<double>();
          await tester.pumpWidgetWithMaterial(
            child: SliderKnob(
              name: '$SliderKnob',
              value: 0.1,
              onChanged: valueChangedCallbackMock,
            ),
          );

          final widgetFinder = find.byType(Slider);

          await tester.setSliderToValue(widgetFinder, 0.7);
          await tester.pumpAndSettle();

          verify(() => valueChangedCallbackMock.call(0.7)).called(1);
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
          final valueChangedCallbackMock = ValueChangedCallbackMock<double?>();
          await tester.pumpWidgetWithMaterial(
            child: NullableSliderKnob(
              name: '$SliderKnob',
              value: 0.1,
              onChanged: valueChangedCallbackMock,
            ),
          );

          final widgetFinder = find.byType(Slider);

          await tester.setSliderToValue(widgetFinder, 0.7);
          await tester.pumpAndSettle();

          verify(
            () => valueChangedCallbackMock.call(0.7),
          ).called(1);
        },
      );

      testWidgets(
        'invokes onChanged when value changes to null',
        (tester) async {
          final valueChangedCallbackMock = ValueChangedCallbackMock<double?>();
          await tester.pumpWidgetWithMaterial(
            child: NullableSliderKnob(
              name: '$SliderKnob',
              value: 0.1,
              onChanged: valueChangedCallbackMock,
            ),
          );

          final widgetFinder = find.byType(Switch);

          await tester.tap(widgetFinder);
          await tester.pumpAndSettle();

          verify(() => valueChangedCallbackMock.call(null)).called(1);
        },
      );
    },
  );
}
