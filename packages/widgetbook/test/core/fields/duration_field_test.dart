import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  List<String> durationInputValues(WidgetTester tester) {
    final fields = tester.widgetList<TextFormField>(find.byType(TextFormField));
    return fields
        .map((field) => field.controller?.text ?? field.initialValue ?? '')
        .toList();
  }

  group('$DurationField', () {
    const fiveSeconds = Duration(seconds: 5);
    const tenSeconds = Duration(seconds: 10);
    const tenSecondsInMilliseconds = '10000';

    final field = DurationField(
      name: 'duration_field',
      initialValue: fiveSeconds,
    );

    test(
      'given a value, '
      'when [toParam] is called, '
      'then it returns the value as a string',
      () {
        final result = field.toParam(tenSeconds);
        expect(result, equals(tenSecondsInMilliseconds));
      },
    );

    test(
      'given a string param, '
      'when [toValue] is called, '
      'then it returns the actual value',
      () {
        final result = field.toValue(tenSecondsInMilliseconds);
        expect(result, equals(tenSeconds));
      },
    );

    testWidgets(
      'given a state that has a field value, '
      'then [toWidget] builds that value',
      (tester) async {
        await tester.pumpField<Duration, Row>(field, tenSeconds);

        expect(find.byType(TextFormField), findsNWidgets(4));
        expect(durationInputValues(tester), equals(['0', '0', '10', '0']));
      },
    );

    testWidgets(
      'given a field, '
      'then [toWidget] builds duration unit labels',
      (tester) async {
        await tester.pumpField<Duration, Row>(field, null);

        expect(find.text('h'), findsOneWidget);
        expect(find.text('m'), findsOneWidget);
        expect(find.text('s'), findsOneWidget);
        expect(find.text('ms'), findsOneWidget);
      },
    );

    testWidgets(
      'given an arg with an initial value, '
      'when [Arg.update] is called with a new value, '
      'then the field displays the updated value',
      (tester) async {
        final arg = DurationArg(fiveSeconds, name: 'delay');

        await tester.pumpWidgetWithState(
          state: WidgetbookState(),
          builder: (context) => arg.buildFields(context),
        );

        expect(durationInputValues(tester), equals(['0', '0', '5', '0']));

        final context = tester.element(find.byType(TextFormField).first);
        arg.update(context, tenSeconds);
        await tester.pumpAndSettle();

        expect(durationInputValues(tester), equals(['0', '0', '10', '0']));
      },
    );

    testWidgets(
      'given the duration input, '
      'when upper bound values are entered, '
      'then it accepts 23:59:59.999',
      (tester) async {
        await tester.pumpField<Duration, Row>(field, Duration.zero);

        await tester.findAndEnter(find.byType(TextFormField).at(0), '23');
        await tester.findAndEnter(find.byType(TextFormField).at(1), '59');
        await tester.findAndEnter(find.byType(TextFormField).at(2), '59');
        await tester.findAndEnter(find.byType(TextFormField).at(3), '999');

        expect(durationInputValues(tester), equals(['23', '59', '59', '999']));
      },
    );
  });
}
