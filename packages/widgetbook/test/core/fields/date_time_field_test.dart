import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/args/args.dart';
import 'package:widgetbook/src/core/fields/field.dart';
import 'package:widgetbook/src/core/state/state.dart';
import 'package:widgetbook/src/core/utils.dart';

import '../../helper/helper.dart';

void main() {
  group('$DateTimeField', () {
    final now = DateTime.now();

    final field = DateTimeField(
      name: 'date_time_field',
      initialValue: now,
      start: now.subtract(const Duration(days: 365)),
      end: now.add(const Duration(days: 365)),
    );

    test(
      'given a value, '
      'when [toParam] is called, '
      'then it returns the value as a string',
      () {
        final result = field.toParam(field.start);
        expect(result, equals(field.toParam(field.start)));
      },
    );

    test(
      'given a string param, '
      'when [toValue] is called, '
      'then it returns the actual value',
      () {
        final result = field.toValue(
          field.toParam(field.start),
        );
        // since the field converts the date time to a string and then back to
        // a date time, the result is missing milliseconds so we should account
        // for that
        final dateTime = DateTime(
          field.start.year,
          field.start.month,
          field.start.day,
          field.start.hour,
          field.start.minute,
        );
        expect(result, equals(dateTime));
      },
    );

    testWidgets(
      'given a state that has a field value, '
      'then [toWidget] builds that value',
      (tester) async {
        final widget = await tester.pumpField<DateTime, TextFormField>(
          field,
          field.end,
        );

        expect(widget.initialValue, equals(field.end.toSimpleFormat()));
      },
    );

    testWidgets(
      'given a field, '
      'then [toWidget] builds the hintText value',
      (tester) async {
        final widget = await tester.pumpField<DateTime, TextField>(
          field,
          null,
        );

        expect(widget.decoration?.hintText, equals('Enter a DateTime'));
      },
    );

    testWidgets(
      'given an arg with an initial value, '
      'when [Arg.update] is called with a new value, '
      'then the field displays the updated value',
      (tester) async {
        final start = now.subtract(const Duration(days: 365));
        final end = now.add(const Duration(days: 365));
        final arg = DateTimeArg(
          now,
          name: 'dateTime',
          start: start,
          end: end,
        );

        await tester.pumpWidgetWithState(
          state: WidgetbookState(),
          builder: (context) => arg.buildFields(context),
        );

        expect(find.text(now.toSimpleFormat()), findsOneWidget);

        final context = tester.element(find.byType(TextFormField));
        final newDateTime = now.add(const Duration(days: 30));
        arg.update(context, newDateTime);
        await tester.pumpAndSettle();

        expect(find.text(newDateTime.toSimpleFormat()), findsOneWidget);
        expect(find.text(now.toSimpleFormat()), findsNothing);
      },
    );
  });
}
