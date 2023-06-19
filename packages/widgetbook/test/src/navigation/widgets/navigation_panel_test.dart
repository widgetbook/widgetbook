import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import '../../../helper/widget_test_helper.dart';

void main() {
  group('$NavigationPanel', () {
    const query = 'component';
    final directories = [
      WidgetbookComponent(
        name: 'Component',
        useCases: [
          WidgetbookUseCase(
            name: 'Use Case 1',
            builder: (_) => const SizedBox.shrink(),
          ),
        ],
      ),
      WidgetbookCategory(
        name: 'Category',
        children: [],
      ),
    ];

    testWidgets(
      'filters nodes when typing into search field',
      (tester) async {
        await tester.pumpWidgetWithMaterialApp(
          NavigationPanel(
            directories: directories,
          ),
        );

        await tester.enterText(
          find.byType(TextFormField),
          query,
        );

        await tester.pumpAndSettle();

        final navNodes = find.byType(NavigationTreeNode);

        expect(
          navNodes,
          findsNWidgets(2),
        );
      },
    );

    testWidgets(
      'resets filtered nodes when search field is cleared',
      (tester) async {
        await tester.pumpWidgetWithMaterialApp(
          NavigationPanel(
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
