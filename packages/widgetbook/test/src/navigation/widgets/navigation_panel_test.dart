import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import '../../../helper/tester_extension.dart';
import '../tree_root.dart';

void main() {
  group('$NavigationPanel', () {
    const query = '1';
    final leafComponentsCount =
        treeRoot
            .findAll(
              (node) =>
                  node is WidgetbookComponent && node.useCases.length == 1,
            )
            .length;

    testWidgets(
      'given a header is provided to NavigationPanel, '
      'then it is displayed above the search field',
      (tester) async {
        await tester.pumpWidgetWithQueryParams(
          queryParams: {},
          builder:
              (_) => NavigationPanel(
                root: treeRoot,
                header: const Placeholder(),
              ),
        );

        expect(find.byType(Placeholder), findsOneWidget);

        final headerDy = tester.getTopLeft(find.byType(Placeholder)).dy;
        final searchDy = tester.getTopLeft(find.byType(TextFormField)).dy;

        expect(headerDy < searchDy, isTrue);
      },
    );

    testWidgets(
      'given header is not provided to NavigationPanel, '
      'then only the search field is displayed at the top',
      (tester) async {
        await tester.pumpWidgetWithQueryParams(
          queryParams: {},
          builder:
              (_) => NavigationPanel(
                root: treeRoot,
              ),
        );

        expect(find.byType(TextFormField), findsOneWidget);
      },
    );

    testWidgets(
      'when search for query, '
      'then only matching nodes are shown',
      (tester) async {
        await tester.pumpWidgetWithQueryParams(
          queryParams: {},
          builder:
              (_) => NavigationPanel(
                root: treeRoot,
              ),
        );

        await tester.findAndEnter(
          find.byType(TextFormField),
          query,
        );

        expect(
          find.byType(NavigationTreeTile),
          findsNWidgets(2),
        );
      },
    );

    testWidgets(
      'when search is cleared, '
      'then the full tree is shown',
      (tester) async {
        await tester.pumpWidgetWithQueryParams(
          queryParams: {},
          builder:
              (_) => NavigationPanel(
                root: treeRoot,
              ),
        );

        await tester.findAndEnter(
          find.byType(TextFormField),
          query,
        );

        await tester.findAndTap(
          find.byIcon(Icons.close),
        );

        expect(
          find.byType(NavigationTreeTile),
          findsNWidgets(
            // exclude root node and leaf components
            treeRoot.count - 1 - leafComponentsCount,
          ),
        );
      },
    );

    testWidgets(
      'when search for query that has special characters, '
      'then the query is handled properly',
      (tester) async {
        await tester.pumpWidgetWithQueryParams(
          queryParams: {},
          builder:
              (_) => NavigationPanel(
                root: treeRoot,
              ),
        );

        await tester.findAndEnter(
          find.byType(TextFormField),
          '[',
        );

        expect(
          find.byType(NavigationTreeTile),
          findsNWidgets(
            // exclude root node and leaf components
            treeRoot.count - 1 - leafComponentsCount,
          ),
        );
      },
    );
  });
}
