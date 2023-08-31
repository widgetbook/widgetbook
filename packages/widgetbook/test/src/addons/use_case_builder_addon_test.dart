import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/mocks.dart';
import '../../helper/tester_extension.dart';

void main() {
  group(
    '$UseCaseBuilderAddon',
    () {
      final color = Colors.red;
      final addon = UseCaseBuilderAddon(
        name: 'Red',
        builder: (context, child) => ColoredBox(
          color: color,
          child: child,
        ),
      );

      test(
        'given a query group, '
        'then [valueFromQueryGroup] can parse the value',
        () {
          final result = addon.valueFromQueryGroup({
            'enable': 'true',
          });

          expect(result, equals(true));
        },
      );

      testWidgets(
        'given a [true] setting, '
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

      test(
        'given a [false] setting, '
        'then [buildUseCase] returns child as-is',
        () {
          const child = Text('child');
          final useCase = addon.buildUseCase(
            MockBuildContext(),
            child,
            false,
          );

          expect(
            useCase,
            equals(child),
          );
        },
      );
    },
  );
}
