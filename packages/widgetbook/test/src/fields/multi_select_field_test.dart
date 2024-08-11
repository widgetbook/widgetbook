import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$MultiSelectField',
    () {
      final field = MultiSelectField<int>(
        name: 'multi_select_field',
        initialValue: [1],
        values: [1, 2, 3],
      );

      test(
        'given a value list, '
        'when [codec.toParam] is called, '
        'then it returns the list as a comma-separated string',
        () {
          final result = field.codec.toParam([1, 2]);
          expect(result, equals('1,2'));
        },
      );

      test(
        'given a comma-separated string, '
        'when [codec.toValue] is called, '
        'then it returns the actual value list',
        () {
          final result = field.codec.toValue('1,2');
          expect(result, equals([1, 2]));
        },
      );

      test(
        'given a comma-separated string with values not in list, '
        'when [codec.toValue] is called, '
        'then it returns an empty list',
        () {
          final result = field.codec.toValue('4,5');
          expect(result, equals([]));
        },
      );

      testWidgets(
        'given a state that has no field value, '
        'then [toWidget] builds the initial value',
        (tester) async {
          final widget = await tester.pumpField<List<int>, Column>(
            field,
            null,
          );

          expect(
            widget.children.whereType<CheckboxListTile>().first.value,
            equals(true),
          );
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'then [toWidget] builds that value',
        (tester) async {
          final widget = await tester.pumpField<List<int>, Column>(
            field,
            [2, 3],
          );

          expect(
            widget.children.whereType<CheckboxListTile>().elementAt(1).value,
            equals(true),
          );
          expect(
            widget.children.whereType<CheckboxListTile>().elementAt(2).value,
            equals(true),
          );
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'when the user selects an additional value, '
        'then the value should be updated',
        (tester) async {
          await tester.pumpField<List<int>, Column>(
            field,
            [2],
          );

          final checkboxListTileFinder = find.byType(CheckboxListTile).at(2);
          await tester.tap(checkboxListTileFinder);
          await tester.pump();

          final selectedCheckbox =
              tester.widget<CheckboxListTile>(checkboxListTileFinder);
          expect(selectedCheckbox.value, equals(true));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'when the user deselects a value, '
        'then the value should be removed',
        (tester) async {
          await tester.pumpField<List<int>, Column>(
            field,
            [1, 2, 3],
          );

          final checkboxListTileFinder = find.byType(CheckboxListTile).at(1);
          await tester.tap(checkboxListTileFinder);
          await tester.pump();

          final selectedCheckbox =
              tester.widget<CheckboxListTile>(checkboxListTileFinder);
          expect(selectedCheckbox.value, equals(false));
        },
      );
    },
  );
}
