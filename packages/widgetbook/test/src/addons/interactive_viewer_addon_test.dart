import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/addons/interactive_viewer_addon/addon.dart';

void main() {
  group(
    '$InteractiveViewerAddon',
    () {
      final addon = InteractiveViewerAddon();

      test(
        'given a default constructor, '
        'minScale should be 1.0',
        () {
          final addon = InteractiveViewerAddon();
          expect(addon.minScale, equals(1.0));
        },
      );

      test(
        'given a default constructor, '
        'maxScale should be 30.0',
        () {
          final addon = InteractiveViewerAddon();
          expect(addon.maxScale, equals(30.0));
        },
      );

      test(
        'given a custom initialZoom, '
        'minScale should match the provided value',
        () {
          const factor = 1.5;
          final addon = InteractiveViewerAddon(
            minScale: factor,
          );

          expect(addon.minScale, equals(factor));
        },
      );

      test(
        'given a custom initialZoom, '
        'maxScale should match the provided value',
        () {
          const factor = 11.0;
          final addon = InteractiveViewerAddon(
            maxScale: factor,
          );

          expect(addon.maxScale, equals(factor));
        },
      );

      test(
        'given a query group with enabled value, '
        'valueFromQueryGroup should return the correct zoom value',
        () {
          const factor = false;
          final result = addon.valueFromQueryGroup({'enabled': '$factor'});
          expect(result, equals(factor));
        },
      );

      test(
        'given a query group without enabled value, '
        'valueFromQueryGroup should return the default value of 1.0',
        () {
          final result = addon.valueFromQueryGroup({});
          expect(result, equals(true));
        },
      );

      testWidgets(
        'given an enabled value, '
        'buildUseCase should use InteractiveViewer above the child',
        (tester) async {
          final child = const Text('Zoom me!');
          await tester.pumpWidget(
            MaterialApp(
              home: addon.buildUseCase(
                tester.element(find.byType(Text)),
                child,
                true,
              ),
            ),
          );

          expect(
            find.ancestor(
              of: find.byWidget(child),
              matching: find.byType(InteractiveViewer),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'given a disabled value, '
        'buildUseCase should not use InteractiveViewer',
        (tester) async {
          final child = const Text('Zoom me!');
          await tester.pumpWidget(
            MaterialApp(
              home: addon.buildUseCase(
                tester.element(find.byType(Text)),
                child,
                false,
              ),
            ),
          );

          expect(
            find.byType(InteractiveViewer),
            findsNothing,
          );
        },
      );
    },
  );
}
