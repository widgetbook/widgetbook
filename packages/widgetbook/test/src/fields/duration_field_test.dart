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

    testWidgets(
      'given a field with enableDays=true, '
      'then [toWidget] builds four input fields (d/h/m/s)',
      (tester) async {
        final fieldWithDays = DurationField(
          name: 'duration_field',
          initialValue: const Duration(
            days: 1,
            hours: 2,
            minutes: 3,
            seconds: 4,
          ),
          enableDays: true,
        );

        await tester.pumpWidget(
          Builder(
            builder: (context) {
              return MaterialApp(
                home: Scaffold(
                  body: fieldWithDays.toWidget(
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
        expect(textFields, findsNWidgets(4));

        final daysField = tester.widget<TextFormField>(textFields.at(0));
        final hoursField = tester.widget<TextFormField>(textFields.at(1));
        final minutesField = tester.widget<TextFormField>(textFields.at(2));
        final secondsField = tester.widget<TextFormField>(textFields.at(3));

        expect(daysField.initialValue, '1');
        expect(hoursField.initialValue, '2');
        expect(minutesField.initialValue, '3');
        expect(secondsField.initialValue, '4');
      },
    );

    testWidgets(
      'given a field with enableMilliseconds=true and enableMicroseconds=true, '
      'then [toWidget] builds five input fields (h/m/s/ms/µs)',
      (tester) async {
        final fieldWithMs = DurationField(
          name: 'duration_field',
          initialValue: const Duration(
            hours: 1,
            minutes: 2,
            seconds: 3,
            milliseconds: 500,
            microseconds: 250,
          ),
          enableMilliseconds: true,
          enableMicroseconds: true,
        );

        await tester.pumpWidget(
          Builder(
            builder: (context) {
              return MaterialApp(
                home: Scaffold(
                  body: fieldWithMs.toWidget(
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
        expect(textFields, findsNWidgets(5));

        final hoursField = tester.widget<TextFormField>(textFields.at(0));
        final minutesField = tester.widget<TextFormField>(textFields.at(1));
        final secondsField = tester.widget<TextFormField>(textFields.at(2));
        final msField = tester.widget<TextFormField>(textFields.at(3));
        final usField = tester.widget<TextFormField>(textFields.at(4));

        expect(hoursField.initialValue, '1');
        expect(minutesField.initialValue, '2');
        expect(secondsField.initialValue, '3');
        expect(msField.initialValue, '500');
        expect(usField.initialValue, '250');
      },
    );

    testWidgets(
      'given a field with all units enabled, '
      'then [toWidget] builds six input fields',
      (tester) async {
        final allUnitsField = DurationField(
          name: 'duration_field',
          initialValue: const Duration(
            days: 1,
            hours: 2,
            minutes: 3,
            seconds: 4,
            milliseconds: 500,
            microseconds: 250,
          ),
          enableDays: true,
          enableMilliseconds: true,
          enableMicroseconds: true,
        );

        await tester.pumpWidget(
          Builder(
            builder: (context) {
              return MaterialApp(
                home: Scaffold(
                  body: allUnitsField.toWidget(
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
        expect(textFields, findsNWidgets(6));
      },
    );

    testWidgets(
      'given a field with enableHours=false, '
      'then [toWidget] builds two input fields (m/s)',
      (tester) async {
        final noHoursField = DurationField(
          name: 'duration_field',
          initialValue: fiveSeconds,
          enableHours: false,
        );

        await tester.pumpWidget(
          Builder(
            builder: (context) {
              return MaterialApp(
                home: Scaffold(
                  body: noHoursField.toWidget(
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
        expect(textFields, findsNWidgets(2));
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
