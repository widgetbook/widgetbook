import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/settings/settings.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

class MockKnob extends Knob<bool?> {
  MockKnob({
    required super.label,
    super.initialValue = true,
    super.description,
    super.isNullable = false,
  });

  @override
  List<Field> get fields => [
    BooleanField(
      name: label,
      initialValue: initialValue,
    ),
  ];

  @override
  bool valueFromQueryGroup(Map<String, String> group) {
    return true;
  }
}

void main() {
  group(
    '$Knob',
    () {
      testWidgets(
        'given a non-nullable knob,'
        'then it should build a [$Setting]',
        (tester) async {
          final knob = MockKnob(
            label: 'Mock Knob',
            description: 'Knob Description',
          );

          await tester.pumpKnob(
            (context) => knob.buildFields(context),
          );

          expect(
            find.byType(Setting),
            findsOneWidget,
          );
        },
      );

      test(
        'given two different knobs, '
        'when they are compared using the equality operator, '
        'then they should return false',
        () {
          final firstKnob = MockKnob(label: 'first');
          final secondKnob = MockKnob(label: 'second');

          expect(
            firstKnob,
            isNot(equals(secondKnob)),
          );
        },
      );

      testWidgets(
        'given a nullable knob with a null value, '
        'then it should build a [$NullableSetting] with a uncheck checkbox',
        (tester) async {
          final knob = MockKnob(
            label: 'Mock Knob',
            isNullable: true,
            initialValue: null,
          );

          await tester.pumpKnob(
            (context) => knob.buildFields(context),
          );

          final checkbox = tester.widget<Checkbox>(
            find.byType(Checkbox),
          );

          expect(
            checkbox.value,
            false,
          );
        },
      );

      testWidgets(
        'given a nullable knob with a value, '
        'then it should build a [$NullableSetting] with a checked checkbox',
        (tester) async {
          final knob = MockKnob(
            label: 'Mock Knob',
            isNullable: true,
            initialValue: false,
          );

          await tester.pumpKnob(
            (context) => knob.buildFields(context),
          );

          final checkbox = tester.widget<Checkbox>(
            find.byType(Checkbox),
          );

          expect(
            checkbox.value,
            true,
          );
        },
      );
    },
  );
}
