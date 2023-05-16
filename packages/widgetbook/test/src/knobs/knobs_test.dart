import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/bool_knob.dart';
import 'package:widgetbook/src/knobs/knob.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

import '../../helper/widget_test_helper.dart';
import 'knob_helper.dart';

void main() {
  testWidgets(
    'Bool knob added',
    (WidgetTester tester) async {
      final knobsNotifier = KnobsNotifier();
      await tester.pumpWithKnob(
        notifier: knobsNotifier,
        (context) => Text(
          context.knobs.boolean(
            label: 'label',
            initialValue: true,
          )
              ? 'Hi'
              : 'Bye',
        ),
      );

      expect(knobsNotifier.all().length, equals(1));

      expect(
        knobsNotifier.all(),
        equals(
          <Knob<dynamic>>[
            BoolKnob(
              label: 'label',
              value: true,
            )
          ],
        ),
      );
    },
  );
}
