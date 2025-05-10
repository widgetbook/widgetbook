import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/widgetbook.dart';

import '../helper/helper.dart';
import 'navigation/tree_root.dart';

void main() {
  group('Widgetbook', () {
    group('with custom header', () {
      testWidgets(
        'when header is provided to NavigationPanel, '
        'then it is displayed above the search field',
        (tester) async {
          // Create a simple custom header with unique text for testing
          const headerText = 'My Design System';
          final header = Container(
            padding: const EdgeInsets.all(8),
            color: Colors.blue.shade100,
            child: const Text(
              headerText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );

          await tester.pumpWidgetWithQueryParams(
            queryParams: {},
            builder: (_) => NavigationPanel(
              root: treeRoot,
              header: header,
            ),
          );

          // Verify the custom header is displayed
          expect(find.text(headerText), findsOneWidget);

          // Verify the search field is still displayed
          expect(find.byType(TextFormField), findsOneWidget);

          // Verify the custom header appears before the search field
          final headerWidget = find.text(headerText);
          final searchFieldWidget = find.byType(TextFormField);

          expect(
            tester.getTopLeft(headerWidget).dy <
                tester.getTopLeft(searchFieldWidget).dy,
            isTrue,
          );
        },
      );

      testWidgets(
        'when header is not provided to NavigationPanel, '
        'then only the search field is displayed at the top',
        (tester) async {
          await tester.pumpWidgetWithQueryParams(
            queryParams: {},
            builder: (_) => NavigationPanel(
              root: treeRoot,
            ),
          );

          // Verify the search field is displayed
          expect(find.byType(TextFormField), findsOneWidget);
        },
      );

      testWidgets(
        'when header is provided to Widgetbook, '
        'then it is passed to the WidgetbookState',
        (tester) async {
          // Create a simple custom header
          final header = Container(
            padding: const EdgeInsets.all(8),
            color: Colors.blue.shade100,
            child: const Text('My Design System'),
          );

          // Create a key to find the Widgetbook widget
          final widgetbookKey = GlobalKey();

          await tester.pumpWidget(
            Widgetbook.material(
              key: widgetbookKey,
              directories: [
                WidgetbookComponent(
                  name: 'Test Component',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Test Use Case',
                      builder: (context) => const SizedBox(),
                    ),
                  ],
                ),
              ],
              header: header,
            ),
          );

          // Wait for the widget tree to settle
          await tester.pumpAndSettle();

          // Verify the custom header is passed to the Widgetbook
          final widgetbookState =
              (widgetbookKey.currentState as State).widget as Widgetbook;
          expect(widgetbookState.header, equals(header));
        },
      );
    });
  });
}
