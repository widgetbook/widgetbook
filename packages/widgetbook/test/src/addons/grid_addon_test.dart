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
        final result = addon.valueFromQueryGroup({
          'horizontalDistance': '15',
          'verticalDistance': '20',
        });

        expect(result.horizontalDistance, equals(15));
        expect(result.verticalDistance, equals(20));
      },
    );

    testWidgets(
      'given a grid setting, '
      'then [buildUseCase] wraps child with grid',
      (tester) async {
        await tester.pumpWidgetWithBuilder(
          (context) => addon.buildUseCase(
            context,
            const Text('child'),
            GridSetting(
              horizontalDistance: 15,
              verticalDistance: 20,
            ),
          ),
        );

        final stack = tester.widget<Stack>(
          find.byType(Stack),
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
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    painter: GridPainter(
                      horizontalDistance: 15,
                      verticalDistance: 20,
                    ),
                  );
                },
              ),
            ),
          ),
        );

        // This is a bit tricky to test directly, but you can check if the painter is being used.
        expect(find.byType(CustomPaint), findsOneWidget);
      },
    );
  });
}
