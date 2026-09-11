import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import '../../../helper/helper.dart';

// Reproduces https://github.com/widgetbook/widgetbook/issues/1890
//
// Every tree level is rendered as a `shrinkWrap: true` non-scrollable
// [ListView], and collapsed folders are hidden with `heightFactor: 0`.
// Both defeat lazy building, so the entire tree is built and laid out
// on every rebuild (e.g. each search keystroke), regardless of the
// viewport size or expansion state.
void main() {
  WidgetbookFolder buildFolder({
    required String name,
    required int componentCount,
    int useCasesPerComponent = 4,
    bool isInitiallyExpanded = true,
  }) {
    return WidgetbookFolder(
      name: name,
      isInitiallyExpanded: isInitiallyExpanded,
      children: [
        for (var i = 0; i < componentCount; i++)
          WidgetbookComponent(
            name: '$name Component $i',
            useCases: [
              for (var j = 0; j < useCasesPerComponent; j++)
                WidgetbookUseCase(
                  name: 'Use-case $j',
                  builder: (_) => Container(),
                ),
            ],
          ),
      ],
    );
  }

  group('$NavigationTreeNode', () {
    testWidgets(
      'given a collapsed folder, '
      'then only its own tile is built, '
      'not the tiles of its hidden descendants',
      (tester) async {
        final folder = buildFolder(
          name: 'Folder',
          componentCount: 3,
          isInitiallyExpanded: false,
        );

        await tester.pumpWidgetWithMaterialApp(
          NavigationTreeNode(
            node: folder,
          ),
        );

        expect(
          find.byType(NavigationTreeTile, skipOffstage: false),
          findsOneWidget,
        );
      },
    );
  });

  group('$NavigationPanel', () {
    testWidgets(
      'given a tree larger than the viewport, '
      'then only the visible nodes are built',
      (tester) async {
        const componentCount = 60;
        const useCasesPerComponent = 4;
        const totalTiles =
            1 + componentCount + componentCount * useCasesPerComponent;

        final root = WidgetbookRoot(
          children: [
            buildFolder(
              name: 'Folder',
              componentCount: componentCount,
              useCasesPerComponent: useCasesPerComponent,
            ),
          ],
        );

        final stopwatch = Stopwatch()..start();
        await tester.pumpWidgetWithQueryParams(
          queryParams: {},
          builder: (_) => NavigationPanel(
            root: root,
          ),
        );
        stopwatch.stop();

        final builtTiles = tester
            .widgetList(find.byType(NavigationTreeTile, skipOffstage: false))
            .length;

        // ignore: avoid_print
        print(
          'Built $builtTiles/$totalTiles tiles '
          'in ${stopwatch.elapsedMilliseconds}ms '
          'for a ${tester.view.physicalSize} viewport',
        );

        expect(builtTiles, lessThan(totalTiles));
      },
    );
  });
}
