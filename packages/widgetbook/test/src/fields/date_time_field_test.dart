import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group('$DateTimeField', () {
    final field = DateTimeField(
      name: 'date_time_field',
      readOnly: false,
    );

    final defaultDateTime = DateTimeField.defaultDateTime;
    final defaultDateTimeText = field.codec.toParam(defaultDateTime);

    final startDateTime = DateTimeField.startDateTime;
    final startDateTimeText = field.codec.toParam(startDateTime);

    final endDateTime = DateTimeField.endDateTime;
    final endDateTimeText = field.codec.toParam(endDateTime);

    String _revertSeparator(String param) {
      return param.replaceAll(DateTimeField.timeSeparator, ':');
    }

    test(
      'given a value, '
      'when [codec.toParam] is called, '
      'then it returns the value as a string',
      () {
        final result = field.codec.toParam(startDateTime);
        expect(result, equals(startDateTimeText));
      },
    );

    test(
      'given a string param, '
      'when [codec.toValue] is called, '
      'then it returns the actual value',
      () {
        final result = field.codec.toValue(startDateTimeText);
        expect(result, equals(startDateTime));
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
          find.text(_revertSeparator(defaultDateTimeText)),
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
          endDateTime,
        );

        expect(widget.initialValue, equals(_revertSeparator(endDateTimeText)));
      },
    );
  });
}
