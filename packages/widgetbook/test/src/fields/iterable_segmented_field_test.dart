import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$IterableSegmentedField',
    () {
      final field = IterableSegmentedField<int>(
        name: 'iterable_segmented_field',
        initialValue: {1},
        values: {1, 2, 3},
      );

      test(
        'given a value, '
        'when [codec.toParam] is called, '
        'then it returns the value as a string',
        () {
          final result = field.codec.toParam({1});
          expect(result, equals('[1]'));
        },
      );

      test(
        'given a string param, '
        'when [codec.toValue] is called, '
        'then it returns the actual value',
        () {
          final result = field.codec.toValue('[1]');
          expect(result, equals({1}));
        },
      );

      test(
        'given a string param that does not exist in values, '
        'when [codec.toValue] is called, '
        'then it throw an exception',
        () {
          expect(() => field.codec.toValue('x'), throwsA(isA<Exception>()));
          expect(() => field.codec.toValue('[x]'), throwsA(isA<Exception>()));
          expect(() => field.codec.toValue('x]'), throwsA(isA<Exception>()));
          expect(() => field.codec.toValue('[x'), throwsA(isA<Exception>()));
        },
      );

      testWidgets(
        'given a state that has no field value, '
        'then [toWidget] builds the initial value',
        (tester) async {
          final widget = await tester
              .pumpField<Iterable<int>, SegmentedButton<int>>(
                field,
                null,
              );

          expect(widget.selected, equals({1}));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'then [toWidget] builds that value',
        (tester) async {
          final widget = await tester
              .pumpField<Iterable<int>, SegmentedButton<int>>(
                field,
                {2},
              );

          expect(widget.selected, equals({2}));
        },
      );
    },
  );
}
