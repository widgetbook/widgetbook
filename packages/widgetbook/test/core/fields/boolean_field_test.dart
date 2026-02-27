import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$BooleanField',
    () {
      final field = BooleanField(
        name: 'boolean_field',
        initialValue: false,
      );

      test(
        'given a value, '
        'when [toParam] is called, '
        'then it returns the value as a string',
        () {
          final result = field.toParam(false);
          expect(result, equals('false'));
        },
      );

      test(
        'given a string param, '
        'when [toValue] is called, '
        'then it returns the actual value',
        () {
          final result = field.toValue('false');
          expect(result, equals(false));
        },
      );

      testWidgets(
        'given a state that has no field value, '
        'then [toWidget] builds the initial value',
        (tester) async {
          final widget = await tester.pumpField<bool, Switch>(
            field,
            null,
          );

          expect(widget.value, equals(false));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'then [toWidget] builds that value',
        (tester) async {
          final widget = await tester.pumpField<bool, Switch>(
            field,
            true,
          );

          expect(widget.value, equals(true));
        },
      );

      testWidgets(
        'given an arg with an initial value, '
        'when [Arg.update] is called with a new value, '
        'then the switch displays the updated value',
        (tester) async {
          final arg = BoolArg(false, name: 'isEnabled');

          await tester.pumpWidgetWithState(
            state: WidgetbookState(),
            builder: (context) => arg.buildFields(context),
          );

          final initialSwitch = tester.widget<Switch>(find.byType(Switch));
          expect(initialSwitch.value, equals(false));

          final context = tester.element(find.byType(Switch));
          arg.update(context, true);
          await tester.pumpAndSettle();

          final updatedSwitch = tester.widget<Switch>(find.byType(Switch));
          expect(updatedSwitch.value, equals(true));
        },
      );

      testWidgets(
        'given a nullable arg with null initial value, '
        'when the checkbox is clicked once, '
        'then the query group is un-nullified',
        (tester) async {
          final arg = NullableBoolArg(null, name: 'isEnabled');
          final state = WidgetbookState();

          await tester.pumpWidgetWithState(
            state: state,
            builder: (context) => arg.buildFields(context),
          );

          // Checkbox should be unchecked initially (value is null = nullified)
          final initialCheckbox = tester.widget<Checkbox>(
            find.byType(Checkbox),
          );
          expect(initialCheckbox.value, equals(false));

          // Click the checkbox once to un-nullify
          await tester.tap(find.byType(Checkbox));
          await tester.pumpAndSettle();

          // The query group should be un-nullified
          final group = state.queryGroups[arg.groupName];
          expect(group, isNotNull);
          expect(group!.isNullified, equals(false));

          // Checkbox should now be checked
          final updatedCheckbox = tester.widget<Checkbox>(
            find.byType(Checkbox),
          );
          expect(updatedCheckbox.value, equals(true));
        },
      );
    },
  );
}
