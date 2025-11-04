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
        precision: null,
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

      test(
        'given a value, '
        'when [codec.toParam] is called with a custom precision, '
        'then it returns the value as a string with expected precision',
        () {
          expect(
            DoubleSliderField(
              name: 'double_slider_field',
              min: 0.0,
              max: 10.0,
              precision: 0,
            ).codec.toParam(1.23456789),
            equals('1'),
          );
          expect(
            DoubleSliderField(
              name: 'double_slider_field',
              min: 0.0,
              max: 10.0,
            ).codec.toParam(1.23456789),
            equals('1.2'),
          );
          expect(
            DoubleSliderField(
              name: 'double_slider_field',
              min: 0.0,
              max: 10.0,
              precision: 5,
            ).codec.toParam(1.23456789),
            equals('1.23457'),
          );
        },
      );
    },
  );
}
