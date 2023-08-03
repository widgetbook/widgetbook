import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$ColorField',
    () {
      const blue = Color(0xFF0000FF);
      const blueHex = 'ff0000ff';

      const red = Color(0xFFFF0000);
      const redHex = 'ffff0000';

      final field = ColorField(
        name: 'color_field',
        initialValue: blue,
      );

      test(
        'given a value, '
        'when [codec.toParam] is called, '
        'then it returns the value as a string',
        () {
          final result = field.codec.toParam(red);
          expect(result, equals(redHex));
        },
      );

      test(
        'given a string param, '
        'when [codec.toValue] is called, '
        'then it returns the actual value',
        () {
          final result = field.codec.toValue(redHex);
          expect(result, equals(red));
        },
      );

      testWidgets(
        'given a state that has no field value, '
        'then [toWidget] builds the initial value',
        (tester) async {
          final widget = await tester.pumpField<Color, TextFormField>(
            field,
            null,
          );

          expect(widget.initialValue, equals(blueHex));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'then [toWidget] builds that value',
        (tester) async {
          final widget = await tester.pumpField<Color, TextFormField>(
            field,
            red,
          );

          expect(widget.initialValue, equals(redHex));
        },
      );
    },
  );
}
