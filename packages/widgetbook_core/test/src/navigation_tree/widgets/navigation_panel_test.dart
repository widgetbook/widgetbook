import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/widget_tester_extension.dart';

void main() {
  group('$NavigationPanel', () {
    const query = 'component';
    const directories = [
      MultiChildNavigationNodeData(
        name: 'Component',
        type: NavigationNodeType.component,
        children: [
          MultiChildNavigationNodeData(
            name: 'Use Case 1',
            type: NavigationNodeType.useCase,
            children: [],
          ),
        ],
      ),
      MultiChildNavigationNodeData(
        name: 'Category',
        type: NavigationNodeType.category,
        children: [],
      ),
    ];

    testWidgets(
      'filters nodes when typing into search field',
      (WidgetTester tester) async {
        await tester.pumpWidgetWithMaterial(
          child: const NavigationPanel(
            directories: directories,
          ),
        );

        await tester.enterText(
          find.byType(TextFormField),
          query,
        );

        final navNodes = find.byType(NavigationTreeNode);

        expect(
          navNodes,
          findsNWidgets(2),
        );
      },
    );

    testWidgets(
      'resets filtered nodes when search field is cleared',
      (WidgetTester tester) async {
        await tester.pumpWidgetWithMaterial(
          child: const NavigationPanel(
            directories: directories,
          ),
        );

        await tester.enterText(
          find.byType(TextFormField),
          query,
        );

        await tester.pumpAndSettle();

        final clearButton = find.byWidgetPredicate(
          (widget) => widget is Icon && widget.icon == Icons.close,
        );

        await tester.tap(clearButton);

        final navNodes = find.byType(NavigationTreeNode);

        expect(
          navNodes,
          findsNWidgets(2),
        );
      },
    );
  });
}
