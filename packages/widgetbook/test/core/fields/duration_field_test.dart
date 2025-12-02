import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group('$DurationField', () {
    const fiveSeconds = Duration(seconds: 5);
    const tenSeconds = Duration(seconds: 10);
    const tenSecondsInMilliseconds = '10000';

    final field = DurationField(
      name: 'duration_field',
      initialValue: fiveSeconds,
    );

    test(
      'given a value, '
      'when [toParam] is called, '
      'then it returns the value as a string',
      () {
        final result = field.toParam(tenSeconds);
        expect(result, equals(tenSecondsInMilliseconds));
      },
    );

    test(
      'given a string param, '
      'when [toValue] is called, '
      'then it returns the actual value',
      () {
        final result = field.toValue(tenSecondsInMilliseconds);
        expect(result, equals(tenSeconds));
      },
    );

    testWidgets(
      'given a state that has a field value, '
      'then [toWidget] builds that value',
      (tester) async {
        final widget = await tester.pumpField<Duration, TextFormField>(
          field,
          tenSeconds,
        );

        expect(widget.initialValue, equals(tenSecondsInMilliseconds));
      },
    );

    testWidgets(
      'given a field, '
      'then [toWidget] builds the hintText value',
      (tester) async {
        final widget = await tester.pumpField<Duration, TextField>(
          field,
          null,
        );

        expect(widget.decoration?.hintText, equals('Enter a duration'));
      },
    );
  });
}
