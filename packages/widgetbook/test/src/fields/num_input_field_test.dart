import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/fields/num_input_field.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$NumInputField Used as double input field',
    () {
      final field = NumInputField(
        name: 'double_input_field',
        initialValue: 5.0,
        type: FieldType.doubleInput,
        formatters: [],
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
          final widget = await tester.pumpField<double, TextFormField>(
            field,
            null,
          );

          expect(widget.initialValue, equals('5.0'));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'then [toWidget] builds that value',
        (tester) async {
          final widget = await tester.pumpField<double, TextFormField>(
            field,
            7.0,
          );

          expect(widget.initialValue, equals('7.0'));
        },
      );

      testWidgets(
        'given a field, '
        'then [toWidget] builds the hintText value',
        (tester) async {
          final widget = await tester.pumpField<double, TextField>(
            field,
            null,
          );

          expect(widget.decoration?.hintText, equals('Enter a number'));
        },
      );
    },
  );

  group('$NumInputField  Used as int input field', () {
    final field = NumInputField(
      name: 'int_field',
      initialValue: 5,
      type: FieldType.intInput,
      formatters: [FilteringTextInputFormatter.digitsOnly],
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
        await tester.pumpWidget(
          Builder(
            builder: (context) {
              return MaterialApp(
                home: Material(
                  child: field.toWidget(
                    context,
                    'int_field',
                    null,
                  ),
                ),
              );
            },
          ),
        );

        expect(find.text('5'), findsOneWidget);
      },
    );

    testWidgets(
      'given a state that has a field value, '
      'then [toWidget] builds that value',
      (tester) async {
        await tester.pumpWidget(
          Builder(
            builder: (context) {
              return MaterialApp(
                home: Material(
                  child: field.toWidget(
                    context,
                    'int_field',
                    7,
                  ),
                ),
              );
            },
          ),
        );

        expect(find.text('7'), findsOneWidget);
      },
    );
  });
}
