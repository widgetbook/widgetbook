import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/layout/desktop_layout.dart';
import 'package:widgetbook/src/core/navigation/navigation.dart';
import 'package:widgetbook/src/core/widgetbook_app.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

/// Whether [finder] is fully inside the bounds of the navigation list.
bool _isVisibleInList(WidgetTester tester, Finder finder) {
  final list = tester.getRect(find.byType(ListView));
  final tile = tester.getRect(finder);
  return tile.top >= list.top && tile.bottom <= list.bottom;
}

List<Component> _components(int count) {
  return List.generate(
    count,
    (index) => Component(
      name: 'Component${index.toString().padLeft(2, '0')}',
      path: 'Catalog',
      stories: [TestStory(name: 'Primary')],
    ),
  );
}

void main() {
  group('$NavigationPanel scrolling', () {
    testWidgets(
      'given a tree that is taller than the panel, '
      'when the app starts with a deep link to a node far down the tree, '
      'then that node is scrolled into view',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(
              initialRoute: '/?path=Catalog/Component49/Primary',
              components: _components(50),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final selectedTile = find.byWidgetPredicate(
          (widget) => widget is FolderTreeTile && widget.isSelected,
        );

        expect(selectedTile, findsOneWidget);
        expect(_isVisibleInList(tester, selectedTile), isTrue);
      },
    );

    testWidgets(
      'given a tree that fits into the panel, '
      'when the app starts with a deep link, '
      'then the list is not scrolled',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(
              initialRoute: '/?path=Catalog/Component01/Primary',
              components: _components(2),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final scrollable = tester.state<ScrollableState>(
          find
              .descendant(
                of: find.byType(ListView),
                matching: find.byType(Scrollable),
              )
              .first,
        );

        expect(scrollable.position.pixels, equals(0));
      },
    );

    testWidgets(
      'given a collapsed tree, '
      'when the path is updated from outside the panel, '
      'then the ancestors are expanded and the node is scrolled into view',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(
              foldersExpandedByDefault: false,
              components: [
                ..._components(50),
                Component(
                  name: 'DeepComponent',
                  path: 'Elsewhere/Group',
                  stories: [TestStory(name: 'Hidden')],
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('DeepComponent'), findsNothing);

        final state = WidgetbookState.of(
          tester.element(find.byType(NavigationPanel)),
        );

        state.updatePath('Elsewhere/Group/DeepComponent/Hidden');
        await tester.pumpAndSettle();

        final selectedTile = find.byWidgetPredicate(
          (widget) => widget is FolderTreeTile && widget.isSelected,
        );

        expect(find.byType(DesktopLayout), findsOneWidget);
        expect(find.text('DeepComponent'), findsOneWidget);
        expect(selectedTile, findsOneWidget);
        expect(_isVisibleInList(tester, selectedTile), isTrue);
      },
    );
  });
}
