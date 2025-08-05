import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/fields/fields.dart';

import '../../helper/helper.dart';

void main() {
  group('$DateTimeField', () {
    final now = DateTime.now();

    final field = DateTimeField(
      name: 'date_time_field',
      initialValue: now,
      start: now.subtract(const Duration(days: 365)),
      end: now.add(const Duration(days: 365)),
    );

    test(
      'given a value, '
      'when [codec.toParam] is called, '
      'then it returns the value as a string',
      () {
        final result = field.codec.toParam(field.start);
        expect(result, equals(field.codec.toParam(field.start)));
      },
    );

    test(
      'given a string param, '
      'when [codec.toValue] is called, '
      'then it returns the actual value',
      () {
        final result = field.codec.toValue(
          field.codec.toParam(field.start),
        );
        // since the codec converts the date time to a string and then back to
        // a date time, the result is missing milliseconds so we should account
        // for that
        final dateTime = DateTime(
          field.start.year,
          field.start.month,
          field.start.day,
          field.start.hour,
          field.start.minute,
        );
        expect(result, equals(dateTime));
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
                home: Scaffold(
                  body: field.toWidget(
                    context,
                    'date_time_field',
                    null,
                  ),
                ),
              );
            },
          ),
        );

        expect(
          find.text(now.toSimpleFormat()),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'given a state that has a field value, '
      'then [toWidget] builds that value',
      (tester) async {
        final widget = await tester.pumpField<DateTime, TextFormField>(
          field,
          field.end,
        );

        expect(widget.initialValue, equals(field.end.toSimpleFormat()));
      },
    );

    testWidgets(
      'given a field, '
      'then [toWidget] builds the hintText value',
      (tester) async {
        final widget = await tester.pumpField<DateTime, TextField>(
          field,
          null,
        );

        expect(widget.decoration?.hintText, equals('Enter a DateTime'));
      },
    );
  });
}
