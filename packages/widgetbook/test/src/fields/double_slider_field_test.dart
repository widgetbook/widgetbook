import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$DoubleSliderField',
    () {
      final field = DoubleSliderField(
        name: 'double_slider_field',
        initialValue: 5.0,
        min: 0.0,
        max: 10.0,
      );

      test(
        'given a value, '
        'when [codec.toParam] is called, '
        'then it returns the value as a string',
        () {
          final result = field.codec.toParam(7.0);
          expect(result, equals('7.0'));
        },
      );

      test(
        'given a string param, '
        'when [codec.toValue] is called, '
        'then it returns the actual value',
        () {
          final result = field.codec.toValue('7.0');
          expect(result, equals(7.0));
        },
      );

      testWidgets(
        'given a state that has no field value, '
        'then [toWidget] builds the initial value',
        (tester) async {
          final widget = await tester.pumpField<double, Slider>(
            field,
            null,
          );

          expect(widget.value, equals(5.0));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'then [toWidget] builds that value',
        (tester) async {
          final widget = await tester.pumpField<double, Slider>(
            field,
            7.0,
          );

          expect(widget.value, equals(7.0));
        },
      );
    },
  );
}
