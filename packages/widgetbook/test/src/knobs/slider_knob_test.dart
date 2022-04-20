import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/knobs/slider_knob.dart';

import '../../helper/widget_test_helper.dart';
import 'knobs_test.dart';

void main() {
  testWidgets(
    'Equality operator works correctly',
    (WidgetTester tester) async {
      final first = SliderKnob(label: 'first', value: 3);
      final second = SliderKnob(label: 'second', value: 3);
      expect(first, equals(SliderKnob(label: 'first', value: 3)));
      expect(first, isNot(equals(second)));
    },
  );

  testWidgets(
    'Slider knob functions',
    (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterialApp(
        renderWithKnobs(
            build: (context) => [
                  Text(
                    context.knobs
                        .slider(
                          label: 'label',
                          initialValue: 5,
                          max: 7,
                          min: 3,
                          divisions: 1,
                        )
                        .toString(),
                  )
                ]),
      );
      expect(find.text('5.0'), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.drag(
        find.byKey(const Key('label-sliderKnob')),
        const Offset(500, 0),
      );
      await tester.pumpAndSettle();
      expect(find.text('7.0'), findsOneWidget);
    },
  );
}
