import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import 'knob_helper.dart';

void main() {
  testWidgets(
    'Equality operator works correctly',
    (WidgetTester tester) async {
      final first = ListKnob<int>(
        label: 'first',
        value: 10,
        options: [
          10,
        ],
      );
      final second = ListKnob<int>(
        label: 'second',
        value: 3,
        options: [
          3,
        ],
      );
      expect(
        first,
        equals(
          ListKnob(
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
      await tester.pumpWithKnob(
        (context) => Text(
          context.knobs.list<String>(
            label: 'label',
            options: [
              'A',
              'B',
            ],
          ),
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
      expect(find.text('B'), findsWidgets);
    },
  );
}
