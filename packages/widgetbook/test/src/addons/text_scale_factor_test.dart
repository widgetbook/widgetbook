import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/tester_extension.dart';

void main() {
  group(
    '$TextScaleAddon',
    () {
      const factor = 3.0;
      final addon = TextScaleAddon(
        min: 1.0,
        max: 4.0,
        divisions: 3,
      );

      test(
        'given a query group, '
        'then [valueFromQueryGroup] can parse the value',
        () {
          final result = addon.valueFromQueryGroup({
            'factor': factor.toStringAsFixed(2),
          });

          expect(result, equals(factor));
        },
      );

      testWidgets(
        'given text scale factor setting, '
        'then [buildUseCase] wraps child with [MediaQuery] widget',
        (tester) async {
          await tester.pumpWidgetWithBuilder(
            (context) => addon.buildUseCase(
              context,
              const Text('child'),
              factor,
            ),
          );

          final mediaQuery = MediaQuery.of(
            tester.element(find.text('child')),
          );

          expect(
            mediaQuery.textScaler,
            equals(const TextScaler.linear(factor)),
          );
        },
      );
    },
  );
}
