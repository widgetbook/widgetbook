import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$DoubleInputField',
    () {
      final field = DoubleInputField(
        name: 'double_input_field',
        initialValue: 5.0,
      );

      test(
        'given a value, '
        'when [toParam] is called, '
        'then it returns the value as a string',
        () {
          final result = field.toParam(7.0);
          expect(result, equals('7.0'));
        },
      );

      test(
        'given a string param, '
        'when [toValue] is called, '
        'then it returns the actual value',
        () {
          final result = field.toValue('7.0');
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
        'given an arg with an initial value, '
        'when [Arg.update] is called with a new value, '
        'then the field displays the updated value',
        (tester) async {
          final arg = DoubleArg(3.14, name: 'value');

          await tester.pumpWidgetWithState(
            state: WidgetbookState(),
            builder: (context) => arg.buildFields(context),
          );

          expect(find.text('3.14'), findsOneWidget);

          final context = tester.element(find.byType(TextFormField));
          arg.update(context, 2.71);
          await tester.pumpAndSettle();

          expect(find.text('2.71'), findsOneWidget);
          expect(find.text('3.14'), findsNothing);
        },
      );
    },
  );
}
