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
        'when [toParam] is called, '
        'then it returns the value as a string',
        () {
          final result = field.toParam({1});
          expect(result, equals('[1]'));
        },
      );

      test(
        'given a string param, '
        'when [toValue] is called, '
        'then it returns the actual value',
        () {
          final result = field.toValue('[1]');
          expect(result, equals({1}));
        },
      );

      test(
        'given a string param that does not exist in values, '
        'when [toValue] is called, '
        'then it throw an exception',
        () {
          expect(() => field.toValue('x'), throwsA(isA<Exception>()));
          expect(() => field.toValue('x]'), throwsA(isA<Exception>()));
          expect(() => field.toValue('[x'), throwsA(isA<Exception>()));
        },
      );

      test(
        'given a string which contain params, '
        'when [toValue] is called, '
        'then it should return valid values',
        () {
          expect(field.toValue('[1,2,x,3,y]'), equals([1, 2, 3]));
          expect(field.toValue('[x]'), equals([]));
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

      testWidgets(
        'given an arg with an initial value, '
        'when [Arg.update] is called with a new value, '
        'then the segmented button displays the updated value',
        (tester) async {
          final arg = IterableArg<int>(
            {1},
            name: 'segments',
            values: {1, 2, 3},
          );

          await tester.pumpWidgetWithState(
            state: WidgetbookState(),
            builder: (context) => arg.buildFields(context),
          );

          var widget = tester.widget<SegmentedButton<int>>(
            find.byType(SegmentedButton<int>),
          );
          expect(widget.selected, equals({1}));

          final context = tester.element(find.byType(SegmentedButton<int>));
          arg.update(context, {2, 3});
          await tester.pumpAndSettle();

          widget = tester.widget<SegmentedButton<int>>(
            find.byType(SegmentedButton<int>),
          );
          expect(widget.selected, equals({2, 3}));
        },
      );
    },
  );
}
