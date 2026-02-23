import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$ObjectDropdownField',
    () {
      final field = ObjectDropdownField<int>(
        name: 'object_dropdown_field',
        initialValue: 1,
        values: [1, 2, 3],
      );

      test(
        'given a value, '
        'when [toParam] is called, '
        'then it returns the value as a string',
        () {
          final result = field.toParam(1);
          expect(result, equals('1'));
        },
      );

      test(
        'given a string param, '
        'when [toValue] is called, '
        'then it returns the actual value',
        () {
          final result = field.toValue('1');
          expect(result, equals(1));
        },
      );

      test(
        'given a string param that does not exist in values, '
        'when [toValue] is called, '
        'then it returns null',
        () {
          final result = field.toValue('x');
          expect(result, equals(null));
        },
      );

      testWidgets(
        'given a state that has no field value, '
        'then [toWidget] builds the initial value',
        (tester) async {
          final widget = await tester.pumpField<int, DropdownMenu<int>>(
            field,
            null,
          );

          expect(widget.initialSelection, equals(1));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'then [toWidget] builds that value',
        (tester) async {
          final widget = await tester.pumpField<int, DropdownMenu<int>>(
            field,
            2,
          );

          expect(widget.initialSelection, equals(2));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'when the text is changed to invalid entry "4", '
        'no exceptions are thrown',
        (tester) async {
          await tester.pumpField<int, DropdownMenu<int>>(
            field,
            2,
          );

          await tester.findAndEnter(find.byType(TextField), '4');

          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
        },
        // The test only works on a desktop platforms, as they allow the
        // drop down text to be edited.
        variant: TargetPlatformVariant.only(TargetPlatform.macOS),
      );

      testWidgets(
        'given an arg with an initial value, '
        'when [Arg.update] is called with a new value, '
        'then the dropdown displays the updated value',
        (tester) async {
          final arg = SingleArg<int>(
            1,
            name: 'dropdown',
            values: [1, 2, 3],
          );

          await tester.pumpWidgetWithState(
            state: WidgetbookState(),
            builder: (context) => arg.buildFields(context),
          );

          var widget = tester.widget<DropdownMenu<int>>(
            find.byType(DropdownMenu<int>),
          );
          expect(widget.initialSelection, equals(1));

          final context = tester.element(find.byType(DropdownMenu<int>));
          arg.update(context, 3);
          await tester.pumpAndSettle();

          widget = tester.widget<DropdownMenu<int>>(
            find.byType(DropdownMenu<int>),
          );
          expect(widget.initialSelection, equals(3));
        },
      );
    },
  );
}
