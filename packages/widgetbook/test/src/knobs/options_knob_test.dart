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
      final first = OptionsKnob<int>(
        label: 'first',
        value: 10,
        options: [
          10,
        ],
      );
      final second = OptionsKnob<int>(
        label: 'second',
        value: 3,
        options: [
          3,
        ],
      );
      expect(
        first,
        equals(
          OptionsKnob(
            value: 10,
            label: 'first',
            options: [
              3,
            ],
          ),
        ),
      );
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
              context.knobs.options<String>(
                label: 'label',
                options: [
                  'A',
                  'B',
                ],
              ),
            )
          ],
        ),
      );
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Text && widget.data == 'A',
        ),
        findsNWidgets(2),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownMenu<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('B').first);
      await tester.pumpAndSettle();
      expect(find.text('B'), findsOneWidget);
    },
  );
}
