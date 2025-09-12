import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  group('$IntInputField', () {
    final field = IntInputField(
      name: 'int_field',
      initialValue: 5,
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
