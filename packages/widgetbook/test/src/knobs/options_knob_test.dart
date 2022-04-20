import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/knobs/options_knob.dart';

import '../../helper/widget_test_helper.dart';
import 'knobs_test.dart';

void main() {
  testWidgets(
    'Equality operator works correctly',
    (WidgetTester tester) async {
      final first = OptionsKnob(
        label: 'first',
        value: 10,
        options: [
          const Option(
            label: 'opt',
            value: 10,
          ),
        ],
      );
      final second = OptionsKnob(
        label: 'second',
        value: 3,
        options: [
          const Option(
            label: 'opt',
            value: 3,
          ),
        ],
      );
      expect(
          first,
          equals(
            OptionsKnob(
              value: 10,
              label: 'first',
              options: [
                const Option(
                  label: 'opt',
                  value: 3,
                )
              ],
            ),
          ));
      expect(first, isNot(equals(second)));
    },
  );

  testWidgets(
    'Options knob functions',
    (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterialApp(
        renderWithKnobs(
            build: (context) => [
                  Text(
                    context.knobs.options(
                      label: 'label',
                      options: [
                        const Option(
                          label: 'first-option',
                          value: 'first-value',
                        ),
                        const Option(
                          label: 'second-option',
                          value: 'second-value',
                        )
                      ],
                    ),
                  )
                ]),
      );
      expect(find.text('first-value'), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('label-optionsKnob')));
      await tester.pumpAndSettle();
      // I have no clue why I have to do this
      await tester.tap(find.text('second-option').at(1));
      await tester.pumpAndSettle();
      expect(find.text('second-value'), findsOneWidget);
    },
  );
}
