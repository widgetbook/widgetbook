import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

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
      'when [codec.toParam] is called, '
      'then it returns the value as a string',
      () {
        final result = field.codec.toParam(tenSeconds);
        expect(result, equals(tenSecondsInMilliseconds));
      },
    );

    test(
      'given a string param, '
      'when [codec.toValue] is called, '
      'then it returns the actual value',
      () {
        final result = field.codec.toValue(tenSecondsInMilliseconds);
        expect(result, equals(tenSeconds));
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
                    'duration_field',
                    null,
                  ),
                ),
              );
            },
          ),
        );

        final textFields = find.byType(TextFormField);
        expect(textFields, findsNWidgets(3));

        final hoursField = tester.widget<TextFormField>(textFields.at(0));
        final minutesField = tester.widget<TextFormField>(textFields.at(1));
        final secondsField = tester.widget<TextFormField>(textFields.at(2));

        expect(hoursField.initialValue, '0');
        expect(minutesField.initialValue, '0');
        expect(secondsField.initialValue, '5');
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
                home: Scaffold(
                  body: field.toWidget(
                    context,
                    'duration_field',
                    tenSeconds,
                  ),
                ),
              );
            },
          ),
        );

        final textFields = find.byType(TextFormField);
        expect(textFields, findsNWidgets(3));

        final hoursField = tester.widget<TextFormField>(textFields.at(0));
        final minutesField = tester.widget<TextFormField>(textFields.at(1));
        final secondsField = tester.widget<TextFormField>(textFields.at(2));

        expect(hoursField.initialValue, '0');
        expect(minutesField.initialValue, '0');
        expect(secondsField.initialValue, '10');
      },
    );

    testWidgets(
      'given a field, '
      'then [toWidget] builds three input fields',
      (tester) async {
        await tester.pumpWidget(
          Builder(
            builder: (context) {
              return MaterialApp(
                home: Scaffold(
                  body: field.toWidget(
                    context,
                    'duration_field',
                    null,
                  ),
                ),
              );
            },
          ),
        );

        final textFields = find.byType(TextFormField);
        expect(textFields, findsNWidgets(3));
      },
    );
  });

  group('Duration Codec', () {
    final codec = FieldCodec<Duration>(
      toParam: (duration) => duration.inMilliseconds.toString(),
      toValue: (param) {
        if (param == null) return null;
        return Duration(milliseconds: int.tryParse(param) ?? 0);
      },
    );

    test('correctly encodes Duration to string', () {
      final duration = const Duration(milliseconds: 500);
      final result = codec.toParam(duration);
      expect(result, '500');
    });

    test('correctly decodes string to Duration', () {
      final string = '500';
      final result = codec.toValue(string);
      expect(result, const Duration(milliseconds: 500));
    });
  });
}
