import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$StringField',
    () {
      final field = StringField(
        name: 'list_field',
        initialValue: 'cat',
      );

      test(
        'given a value, '
        'when [toParam] is called, '
        'then it returns the value as a string',
        () {
          final result = field.toParam('doggo');
          expect(result, equals('doggo'));
        },
      );

      test(
        'given a string param, '
        'when [toValue] is called, '
        'then it returns the actual value',
        () {
          final result = field.toValue('doggo');
          expect(result, equals('doggo'));
        },
      );

      testWidgets(
        'given a state that has no field value, '
        'then [toWidget] builds the initial value',
        (tester) async {
          final widget = await tester.pumpField<String, TextFormField>(
            field,
            null,
          );

          expect(widget.initialValue, equals('cat'));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'then [toWidget] builds that value',
        (tester) async {
          final widget = await tester.pumpField<String, TextFormField>(
            field,
            'doggo',
          );

          expect(widget.initialValue, equals('doggo'));
        },
      );

      testWidgets(
        'given a state that has a field value with reserved character, '
        'then [toWidget] builds that value correctly',
        (tester) async {
          const value = 'doggo, ';
          final widget = await tester.pumpField<String, TextFormField>(
            field,
            value,
          );

          expect(widget.initialValue, equals(value));
        },
      );

      testWidgets(
        'given a field, '
        'then [toWidget] builds the hintText value',
        (tester) async {
          final widget = await tester.pumpField<String, TextField>(
            field,
            null,
          );

          expect(widget.decoration?.hintText, equals('Enter a value'));
        },
      );

      testWidgets(
        'given an arg with an initial value, '
        'when [Arg.update] is called with a new value, '
        'then the field displays the updated value',
        (tester) async {
          final arg = StringArg('hello', name: 'message');

          await tester.pumpWidgetWithState(
            state: WidgetbookState(),
            builder: (context) => arg.buildFields(context),
          );

          expect(find.text('hello'), findsOneWidget);

          final context = tester.element(find.byType(TextFormField));
          arg.update(context, 'world');
          await tester.pumpAndSettle();

          expect(find.text('world'), findsOneWidget);
          expect(find.text('hello'), findsNothing);
        },
      );
    },
  );
}
