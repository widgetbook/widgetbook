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
      'then [valueFromQueryGroup] returns current dimension',
      () {
        final result = addon.valueFromQueryGroup({});

        expect(result, addon.dimension);
      },
    );

    testWidgets(
      'given a grid dimension, '
      'then [buildUseCase] wraps child with stack',
      (tester) async {
        await tester.pumpWidgetWithBuilder(
          (context) => addon.buildUseCase(
            context,
            const Text('child'),
            15,
          ),
        );

        final stack = find.byWidgetPredicate(
          (widget) {
            return widget is Stack &&
                widget.children.length == 2 &&
                widget.children[0] is LayoutBuilder &&
                widget.children[1] is Text;
          },
        );

        expect(stack, findsOneWidget);
      },
    );

    testWidgets(
      'given a grid setting, '
      'then [GridPainter] paints the grid correctly',
      (tester) async {
        const dimension = 20;
        await tester.pumpWidgetWithBuilder(
          (context) => addon.buildUseCase(
            context,
            const Text('child'),
            dimension,
          ),
        );

        final paintWidget = find.descendant(
          of: find.byType(Stack),
          matching: find.byType(CustomPaint),
        );

        final customPaint = tester.widget<CustomPaint>(paintWidget);

        expect(paintWidget, findsOneWidget);
        expect(
          customPaint,
          predicate<CustomPaint>(
            (widget) {
              final painter = widget.painter as GridPainter;
              return painter.dimension == dimension;
            },
          ),
        );
      },
    );
  });
}
