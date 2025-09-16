import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/fields/num_slider_field.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$NumSliderField Used as double slider field',
    () {
      final field = NumSliderField(
        name: 'double_slider_field',
        initialValue: 5.0,
        min: 0.0,
        max: 10.0,
        type: FieldType.doubleSlider,
        codec: FieldCodec(
          toParam: (value) => value.toString(),
          toValue: (param) => double.tryParse(param ?? ''),
        ),
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

  group(
    '$NumSliderField Used as int slider field',
    () {
      final field = NumSliderField(
        name: 'int_slider_field',
        initialValue: 5,
        min: 0,
        max: 10,
        type: FieldType.intSlider,
        codec: FieldCodec(
          toParam: (value) => value.toString(),
          toValue: (param) => int.tryParse(param ?? ''),
        ),
      );

      test(
        'given a value, '
        'when [codec.toParam] is called, '
        'then it returns the value as a string',
        () {
          final result = field.codec.toParam(7);
          expect(result, equals('7'));
        },
      );

      test(
        'given a string param, '
        'when [codec.toValue] is called, '
        'then it returns the actual value',
        () {
          final result = field.codec.toValue('7');
          expect(result, equals(7));
        },
      );

      testWidgets(
        'given a state that has no field value, '
        'then [toWidget] builds the initial value',
        (tester) async {
          final widget = await tester.pumpField<int, Slider>(
            field,
            null,
          );

          expect(widget.value, equals(5));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'then [toWidget] builds that value',
        (tester) async {
          final widget = await tester.pumpField<int, Slider>(
            field,
            7,
          );

          expect(widget.value, equals(7));
        },
      );

      testWidgets(
        'given a state that exceed field higher limits, '
        'then [toWidget] builds and use the maximum available value',
        (tester) async {
          final widget = await tester.pumpField<int, Slider>(
            field,
            15,
          );

          expect(widget.value, equals(10.0));
        },
      );

      testWidgets(
        'given a state that exceed field lower limits, '
        'then [toWidget] builds and use the minmum available value',
        (tester) async {
          final widget = await tester.pumpField<int, Slider>(
            field,
            -15,
          );

          expect(widget.value, equals(0.0));
        },
      );
    },
  );
}
