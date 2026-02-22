import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

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

    testWidgets(
      'given an arg with an initial value, '
      'when [Arg.update] is called with a new value, '
      'then the field displays the updated value',
      (tester) async {
        final arg = IntArg(5, name: 'count');

        await tester.pumpWidgetWithState(
          state: WidgetbookState(),
          builder: (context) => arg.buildFields(context),
        );

        expect(find.text('5'), findsOneWidget);

        final context = tester.element(find.byType(TextFormField));
        arg.update(context, 10);
        await tester.pumpAndSettle();

        expect(find.text('10'), findsOneWidget);
        expect(find.text('5'), findsNothing);
      },
    );
  });
}
