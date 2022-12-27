import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$ExpanderIcon',
    () {
      testWidgets(
        'rotation turns is 0 when not expanded',
        (tester) async {
          await tester.pumpWidgetWithMaterial(
            child: const ExpanderIcon(),
          );

          final rotationWidget = tester
              .firstWidget(find.byType(AnimatedRotation)) as AnimatedRotation;
          expect(rotationWidget.turns, 0);
        },
      );

      testWidgets(
        'rotation turns is 0.25 when expanded',
        (tester) async {
          await tester.pumpWidgetWithMaterial(
            child: const ExpanderIcon(isExpanded: true),
          );

          final rotationWidget = tester
              .firstWidget(find.byType(AnimatedRotation)) as AnimatedRotation;
          expect(rotationWidget.turns, 0.25);
        },
      );
    },
  );
}
