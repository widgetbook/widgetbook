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

  testWidgets(
    'Options knob works with non-string types',
    (WidgetTester tester) async {
      await tester.pumpWithKnob(
        (context) => Icon(
          context.knobs.list<IconData>(
            label: 'RemoveIcon',
            options: [Icons.remove, Icons.crop_square_sharp, Icons.circle],
          ),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Icon && widget.icon == Icons.remove,
        ),
        findsOneWidget,
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownMenu<IconData>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('${Icons.circle}').first);
      await tester.pumpAndSettle();
      expect(find.text('${Icons.circle}'), findsWidgets);
    },
  );

  testWidgets(
    'Options knob works with labelBuilder',
    (WidgetTester tester) async {
      await tester.pumpWithKnob(
        (context) => Icon(
          context.knobs.list<IconData>(
            label: 'RemoveIcon',
            options: [Icons.remove, Icons.crop_square_sharp, Icons.circle],
            labelBuilder: (value) => value.toString() + ' icon',
          ),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Icon && widget.icon == Icons.remove,
        ),
        findsOneWidget,
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownMenu<IconData>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('${Icons.circle} icon').first);
      await tester.pumpAndSettle();
      expect(find.text('${Icons.circle} icon'), findsWidgets);
    },
  );

  testWidgets(
    'Options knob respect initial selected option',
    (WidgetTester tester) async {
      await tester.pumpWithKnob(
        (context) => Icon(
          context.knobs.list<IconData>(
            label: 'RemoveIcon',
            options: [Icons.remove, Icons.crop_square_sharp, Icons.circle],
            initialOption: Icons.circle,
            labelBuilder: (value) => value.toString() + ' icon',
          ),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Icon && widget.icon == Icons.circle,
        ),
        findsOneWidget,
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownMenu<IconData>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('${Icons.remove} icon').first);
      await tester.pumpAndSettle();
      expect(find.text('${Icons.remove} icon'), findsWidgets);
    },
  );
}
