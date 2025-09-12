import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$StringField',
    () {
      final field = StringField(
        name: 'list_field',
        initialValue: 'cat',
      );

      test(
        'given a value, '
        'when [codec.toParam] is called, '
        'then it returns the value as a string',
        () {
          final result = field.codec.toParam('doggo');
          expect(result, equals('doggo'));
        },
      );

      test(
        'given a string param, '
        'when [codec.toValue] is called, '
        'then it returns the actual value',
        () {
          final result = field.codec.toValue('doggo');
          expect(result, equals('doggo'));
        },
      );

      testWidgets(
        'given a state that has no field value, '
        'then [toWidget] builds the initial value',
        (tester) async {
          final widget = await tester.pumpField<String, TextFormField>(
            field,
            null,
          );

          expect(widget.initialValue, equals('cat'));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'then [toWidget] builds that value',
        (tester) async {
          final widget = await tester.pumpField<String, TextFormField>(
            field,
            'doggo',
          );

          expect(widget.initialValue, equals('doggo'));
        },
      );

      testWidgets(
        'given a state that has a field value with reserved character, '
        'then [toWidget] builds that value correctly',
        (tester) async {
          const value = 'doggo, ';
          final widget = await tester.pumpField<String, TextFormField>(
            field,
            value,
          );

          expect(widget.initialValue, equals(value));
        },
      );

      testWidgets(
        'given a field, '
        'then [toWidget] builds the hintText value',
        (tester) async {
          final widget = await tester.pumpField<String, TextField>(
            field,
            null,
          );

          expect(widget.decoration?.hintText, equals('Enter a value'));
        },
      );
    },
  );
}
