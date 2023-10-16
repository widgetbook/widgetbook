import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import '../../../helper/tester_extension.dart';
import '../tree_root.dart';

void main() {
  group('$NavigationPanel', () {
    const query = '1';

    testWidgets(
      'when search for query, '
      'then only matching nodes are shown',
      (tester) async {
        await tester.pumpWidgetWithQueryParams(
          queryParams: {},
          builder: (context) => NavigationPanel(
            root: treeRoot,
          ),
        );

        await tester.findAndEnter(
          find.byType(TextFormField),
          query,
        );

        expect(
          find.byType(NavigationTreeTile),
          findsNWidgets(3),
        );
      },
    );

    testWidgets(
      'when search is cleared, '
      'then the full tree is shown',
      (tester) async {
        await tester.pumpWidgetWithQueryParams(
          queryParams: {},
          builder: (context) => NavigationPanel(
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
          findsNWidgets(treeRoot.count - 1), // exclude root node
        );
      },
    );
  });
}
