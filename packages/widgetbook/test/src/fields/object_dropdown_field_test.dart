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
        'when [codec.toParam] is called, '
        'then it returns the value as a string',
        () {
          final result = field.codec.toParam(1);
          expect(result, equals('1'));
        },
      );

      test(
        'given a string param, '
        'when [codec.toValue] is called, '
        'then it returns the actual value',
        () {
          final result = field.codec.toValue('1');
          expect(result, equals(1));
        },
      );

      test(
        'given a string param that does not exist in values, '
        'when [codec.toValue] is called, '
        'then it returns null',
        () {
          final result = field.codec.toValue('x');
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
    },
  );
}
