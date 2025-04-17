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
        await tester.pumpField<Duration, Row>(
          field,
          null,
        );

        expect(
          find.widgetWithText(TextFormField, '00').evaluate().length,
          3,
        ); // days, hours, minutes
        expect(
          find.widgetWithText(TextFormField, '05'),
          findsOneWidget,
        ); // seconds

        // verify field by specific labels
        expect(
          find.descendant(
            of: find.widgetWithText(TextFormField, 'd'),
            matching: find.text('00'),
          ),
          findsOneWidget,
        );

        expect(
          find.descendant(
            of: find.widgetWithText(TextFormField, 'h'),
            matching: find.text('00'),
          ),
          findsOneWidget,
        );

        expect(
          find.descendant(
            of: find.widgetWithText(TextFormField, 'm'),
            matching: find.text('00'),
          ),
          findsOneWidget,
        );

        expect(
          find.descendant(
            of: find.widgetWithText(TextFormField, 's'),
            matching: find.text('05'),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'given a state that has a field value, '
      'then [toWidget] builds that value',
      (tester) async {
        await tester.pumpField<Duration, Row>(
          field,
          tenSeconds,
        );

        expect(
          find.widgetWithText(TextFormField, '00').evaluate().length,
          3,
        ); // days, hours, minutes
        expect(
          find.widgetWithText(TextFormField, '10'),
          findsOneWidget,
        ); // seconds

        // verify field by specific labels
        expect(
          find.descendant(
            of: find.widgetWithText(TextFormField, 'd'),
            matching: find.text('00'),
          ),
          findsOneWidget,
        );

        expect(
          find.descendant(
            of: find.widgetWithText(TextFormField, 'h'),
            matching: find.text('00'),
          ),
          findsOneWidget,
        );

        expect(
          find.descendant(
            of: find.widgetWithText(TextFormField, 'm'),
            matching: find.text('00'),
          ),
          findsOneWidget,
        );

        expect(
          find.descendant(
            of: find.widgetWithText(TextFormField, 's'),
            matching: find.text('10'),
          ),
          findsOneWidget,
        );
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
