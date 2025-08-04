import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/tester_extension.dart';

void main() {
  group(
    '$BuilderAddon',
    () {
      final color = Colors.red;
      final addon = BuilderAddon(
        name: 'Red',
        builder:
            (context, child) => ColoredBox(
              color: color,
              child: child,
            ),
      );

      testWidgets(
        'given a any setting, '
        'then [buildUseCase] wraps child with [ColoredBox] widget',
        (tester) async {
          await tester.pumpWidgetWithBuilder(
            (context) => addon.buildUseCase(
              context,
              const Text('child'),
              true,
            ),
          );

          final coloredBox = tester.widget<ColoredBox>(
            find.byType(ColoredBox),
          );

          expect(
            coloredBox.color,
            equals(color),
          );
        },
      );
    },
  );
}
