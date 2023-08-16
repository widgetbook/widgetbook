import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import '../../../helper/tester_extension.dart';

void main() {
  group(
    '$ExpanderIcon',
    () {
      testWidgets(
        'rotation turns is 0 when not expanded',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            const ExpanderIcon(),
          );

          final rotation = tester.firstWidget<AnimatedRotation>(
            find.byType(AnimatedRotation),
          );

          expect(rotation.turns, 0);
        },
      );

      testWidgets(
        'rotation turns is 0.25 when expanded',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            const ExpanderIcon(
              isExpanded: true,
            ),
          );

          final rotation = tester.firstWidget<AnimatedRotation>(
            find.byType(AnimatedRotation),
          );

          expect(rotation.turns, 0.25);
        },
      );
    },
  );
}
