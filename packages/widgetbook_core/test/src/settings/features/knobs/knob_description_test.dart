import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/src/settings/features/knobs/knob_description.dart';

import '../../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$KnobDescription',
    () {
      testWidgets(
        'shows description when not null',
        (tester) async {
          const description = 'Description';
          await tester.pumpWidgetWithMaterial(
            child: const KnobDescription(
              description: description,
            ),
          );

          final widgetFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == description,
          );

          expect(widgetFinder, findsOneWidget);
        },
      );

      testWidgets(
        'shows no description',
        (tester) async {
          const description = 'Description';
          await tester.pumpWidgetWithMaterial(
            child: const KnobDescription(),
          );

          final widgetFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == description,
          );

          expect(widgetFinder, findsNothing);
        },
      );
    },
  );
}
