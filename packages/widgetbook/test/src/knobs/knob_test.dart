import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/settings/knob_property.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

class MockKnob extends Knob<bool> {
  MockKnob({
    required super.label,
    super.value = true,
    super.description,
  });

  @override
  List<Field> get fields => [];

  @override
  bool valueFromQueryGroup(Map<String, String> group) {
    return true;
  }
}

void main() {
  final knob = MockKnob(
    label: 'Mock Knob',
    description: 'Knob Description',
  );

  group(
    '$Knob',
    () {
      testWidgets(
        'then it should build a [KnobProperty]',
        (tester) async {
          await tester.pumpKnob(
            (context) => knob.buildFields(context),
          );

          expect(
            find.byType(KnobProperty<bool>),
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
    },
  );
}
