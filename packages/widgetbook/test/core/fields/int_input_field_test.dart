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
      'when [toParam] is called, '
      'then it returns the value as a string',
      () {
        final result = field.toParam(7);
        expect(result, equals('7'));
      },
    );

    test(
      'given a string param, '
      'when [toValue] is called, '
      'then it returns the actual value',
      () {
        final result = field.toValue('7');
        expect(result, equals(7));
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
