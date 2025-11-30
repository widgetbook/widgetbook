import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/fields/fields.dart';

import '../../helper/helper.dart';

void main() {
  testWidgets('duration picker updates the field value', (tester) async {
    final field = DurationField(name: 'test_duration');
    const groupKey = 'group_key';

    final state = await tester.pumpWidgetWithQueryParams(
      queryParams: {},
      builder: (context) => field.build(context, groupKey),
    );

    // Find the three number fields (h:m:s)
    final numberFields = find.byType(TextFormField);
    expect(numberFields, findsNWidgets(3));

    // Enter 2:30:45 (2 hours, 30 minutes, 45 seconds)
    await tester.enterText(numberFields.at(0), '2'); // hours
    await tester.enterText(numberFields.at(1), '30'); // minutes
    await tester.enterText(numberFields.at(2), '45'); // seconds
    await tester.pumpAndSettle();

    // Decode the query param and verify the stored Duration
    final groupMap = FieldCodec.decodeQueryGroup(state.queryParams[groupKey]);
    final value = field.valueFrom(groupMap);

    expect(value, const Duration(hours: 2, minutes: 30, seconds: 45));
  });

  testWidgets('duration picker displays initial value', (tester) async {
    final field = DurationField(
      name: 'test_duration',
      initialValue: const Duration(hours: 1, minutes: 15, seconds: 30),
    );
    const groupKey = 'group_key';

    await tester.pumpWidgetWithQueryParams(
      queryParams: {},
      builder: (context) => field.build(context, groupKey),
    );

    // Find the three number fields (h:m:s)
    final numberFields = find.byType(TextFormField);
    expect(numberFields, findsNWidgets(3));

    // Verify initial values are displayed
    final hoursField = tester.widget<TextFormField>(numberFields.at(0));
    final minutesField = tester.widget<TextFormField>(numberFields.at(1));
    final secondsField = tester.widget<TextFormField>(numberFields.at(2));

    expect(hoursField.initialValue, '1');
    expect(minutesField.initialValue, '15');
    expect(secondsField.initialValue, '30');
  });
}
