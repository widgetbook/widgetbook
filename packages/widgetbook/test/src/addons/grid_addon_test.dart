import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group('$GridAddon', () {
    final addon = GridAddon();

    test(
      'given a query group, '
      'then [valueFromQueryGroup] can parse the value',
      () {
        final result = addon.valueFromQueryGroup({'size': '15'});

        expect(result.size, equals(15));
      },
    );

    testWidgets(
      'given a grid setting, '
      'then [buildUseCase] wraps child with grid',
      (tester) async {
        final testKey = UniqueKey();

        await tester.pumpWidgetWithBuilder(
          (context) => addon.buildUseCase(
            context,
            const Text('child'),
            GridSetting(size: 15),
            key: testKey,
          ),
        );

        final stack = tester.widget<Stack>(
          find.byKey(testKey),
        );

        expect(stack.children.length, equals(2));
        expect(stack.children[0], isA<LayoutBuilder>());
        expect(stack.children[1], isA<Text>());
      },
    );

    testWidgets(
      'given a grid setting, '
      'then [GridPainter] paints the grid correctly',
      (tester) async {
        final testKey = UniqueKey();

        await tester.pumpWidget(
          Builder(
            builder: (context) {
              return MaterialApp(
                home: Scaffold(
                  body: addon.buildUseCase(
                    context,
                    const Text('child'),
                    GridSetting(size: 20),
                    key: testKey,
                  ),
                ),
              );
            },
          ),
        );

        // Find the CustomPaint widget that is a descendant of the Stack with the specific key.
        final paintWidget = find.descendant(
          of: find.byKey(testKey),
          matching: find.byType(CustomPaint),
        );

        final customPaint = tester.widget<CustomPaint>(paintWidget);

        expect(paintWidget, findsOneWidget);
        expect(
          customPaint,
          isGridPainterWith(horizontalDistance: 20, verticalDistance: 20),
        );
      },
    );
  });
}
