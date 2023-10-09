import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group('$GridAddon', () {
    final addon = GridAddon();

    test('throws an assertion error when dimension is 0', () {
      expect(() => GridAddon(0), throwsA(isA<AssertionError>()));
    });

    test(
      'given a query group, '
      'then [valueFromQueryGroup] can parse the value',
      () {
        final result = addon.valueFromQueryGroup({});

        expect(result, addon.dimension);
      },
    );

    testWidgets(
      'given a grid dimension, '
      'then [buildUseCase] wraps child with grid',
      (tester) async {
        await tester.pumpWidgetWithBuilder(
          (context) => addon.buildUseCase(
            context,
            const Text('child'),
            15,
          ),
        );

        final stackWithBoth = find.byWidgetPredicate(
          (widget) {
            if (widget is Stack) {
              bool hasLayoutBuilder = false;
              bool hasText = false;

              for (final child in widget.children) {
                if (child is LayoutBuilder) {
                  hasLayoutBuilder = true;
                } else if (child is Text) {
                  hasText = true;
                }
              }

              return hasLayoutBuilder && hasText;
            }
            return false;
          },
        );

        expect(stackWithBoth, findsOneWidget);
      },
    );

    testWidgets(
      'given a grid setting, '
      'then [GridPainter] paints the grid correctly',
      (tester) async {
        await tester.pumpWidgetWithBuilder(
          (context) => addon.buildUseCase(context, const Text('child'), 20),
        );

        // Find the CustomPaint widget that is a descendant of the Stack.
        final paintWidget = find.descendant(
          of: find.byType(Stack),
          matching: find.byType(CustomPaint),
        );

        final customPaint = tester.widget<CustomPaint>(paintWidget);

        expect(paintWidget, findsOneWidget);
        expect(
          customPaint,
          isGridPainterWith(dimension: 20),
        );
      },
    );
  });
}
