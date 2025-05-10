import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import '../../../helper/tester_extension.dart';
import '../tree_root.dart';

void main() {
  group('$NavigationPanel with custom header', () {
    testWidgets(
      'when custom header is provided, '
      'then it is displayed above the search field',
      (tester) async {
        const headerText = 'Custom Header';
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
      'when custom header is not provided, '
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
  });
}
