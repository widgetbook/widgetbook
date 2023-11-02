import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  group(
    '$ZoomAddon',
    () {
      final addon = ZoomAddon();

      test(
        'given a default constructor, '
        'initialSetting should be 1.0',
        () {
          final addon = ZoomAddon();
          expect(addon.initialZoom, equals(1.0));
        },
      );

      test(
        'given a custom initialZoom, '
        'initialSetting should match the provided value',
        () {
          const factor = 1.5;
          final addon = ZoomAddon(
            initialZoom: factor,
          );

          expect(addon.initialZoom, equals(factor));
        },
      );

      test(
        'given a query group with zoom value, '
        'valueFromQueryGroup should return the correct zoom value',
        () {
          const factor = 1.5;
          final result = addon.valueFromQueryGroup({'zoom': '$factor'});
          expect(result, equals(factor));
        },
      );

      test(
        'given a query group without zoom value, '
        'valueFromQueryGroup should return the default value of 1.0',
        () {
          final result = addon.valueFromQueryGroup({});
          expect(result, equals(1.0));
        },
      );

      testWidgets(
        'given a zoom value, '
        'buildUseCase should scale the child accordingly',
        (tester) async {
          const factor = 1.5;
          final child = const Text('Zoom me!');
          await tester.pumpWidget(
            MaterialApp(
              home: addon.buildUseCase(
                tester.element(find.byType(Text)),
                child,
                factor,
              ),
            ),
          );

          final transform = tester.widget<Transform>(
            find.byType(Transform),
          );

          expect(
            transform.transform.getMaxScaleOnAxis(),
            equals(factor),
          );
        },
      );
    },
  );
}
