import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/layout/desktop_layout.dart';
import 'package:widgetbook/src/core/navigation/navigation.dart';
import 'package:widgetbook/src/core/widgetbook_app.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

final _selectedTile = find.byWidgetPredicate(
  (widget) => widget is FolderTreeTile && widget.isSelected,
);

/// Whether [finder] is fully inside the bounds of the navigation list.
bool _isVisibleInList(WidgetTester tester, Finder finder) {
  final list = tester.getRect(find.byType(ListView));
  final tile = tester.getRect(finder);
  return tile.top >= list.top && tile.bottom <= list.bottom;
}

ScrollPosition _listPosition(WidgetTester tester) {
  return tester
      .state<ScrollableState>(
        find
            .descendant(
              of: find.byType(ListView),
              matching: find.byType(Scrollable),
            )
            .first,
      )
      .position;
}

WidgetbookState _state(WidgetTester tester) {
  return WidgetbookState.of(tester.element(find.byType(NavigationPanel)));
}

void _setViewSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
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
        _setViewSize(tester, const Size(1200, 800));

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(
              initialRoute: '/?path=Catalog/Component49/Primary',
              components: _components(50),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(_selectedTile, findsOneWidget);
        expect(_isVisibleInList(tester, _selectedTile), isTrue);
      },
    );

    testWidgets(
      'given a tree that is taller than the panel, '
      'when the app starts with a deep link to a node in the middle, '
      'then that node is centered in the list',
      (tester) async {
        _setViewSize(tester, const Size(1200, 800));

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(
              initialRoute: '/?path=Catalog/Component25/Primary',
              components: _components(50),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final list = tester.getRect(find.byType(ListView));
        final tile = tester.getRect(_selectedTile);

        expect(tile.center.dy, moreOrLessEquals(list.center.dy));
      },
    );

    testWidgets(
      'given a tree with many categories, '
      'when the app starts with a deep link to the last node, '
      'then that node is scrolled into view',
      (tester) async {
        _setViewSize(tester, const Size(1200, 800));

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(
              initialRoute: '/?path=[Category59]/Component59/Primary',
              components: List.generate(
                60,
                (index) => Component(
                  name: 'Component$index',
                  path: '[Category$index]',
                  stories: [TestStory(name: 'Primary')],
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(_selectedTile, findsOneWidget);
        expect(_isVisibleInList(tester, _selectedTile), isTrue);
      },
    );

    testWidgets(
      'given a tree that fits into the panel, '
      'when the app starts with a deep link, '
      'then the list is not scrolled',
      (tester) async {
        _setViewSize(tester, const Size(1200, 800));

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(
              initialRoute: '/?path=Catalog/Component01/Primary',
              components: _components(2),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(_listPosition(tester).pixels, equals(0));
      },
    );

    testWidgets(
      'given a tree that is taller than the panel, '
      'when the path is updated to a node that is already visible, '
      'then the list is not scrolled',
      (tester) async {
        _setViewSize(tester, const Size(1200, 800));

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(components: _components(50)),
          ),
        );
        await tester.pumpAndSettle();

        _state(tester).updatePath('Catalog/Component02/Primary');
        await tester.pumpAndSettle();

        expect(_selectedTile, findsOneWidget);
        expect(_listPosition(tester).pixels, equals(0));
      },
    );

    testWidgets(
      'given a tree that is taller than the panel, '
      'when the path is updated to a node just below the visible area, '
      'then the list animates to that node',
      (tester) async {
        _setViewSize(tester, const Size(1200, 800));

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(components: _components(50)),
          ),
        );
        await tester.pumpAndSettle();

        _state(tester).updatePath('Catalog/Component08/Primary');
        await tester.pump();
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        final midAnimation = _listPosition(tester).pixels;

        await tester.pumpAndSettle();

        expect(midAnimation, greaterThan(0));
        expect(midAnimation, lessThan(_listPosition(tester).pixels));
        expect(_isVisibleInList(tester, _selectedTile), isTrue);
      },
    );

    testWidgets(
      'given a search query that filters out the selected node, '
      'when the path is updated, '
      'then the list is not scrolled',
      (tester) async {
        _setViewSize(tester, const Size(1200, 800));

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(components: _components(50)),
          ),
        );
        await tester.pumpAndSettle();

        _state(tester).updateQuery('Component0');
        await tester.pumpAndSettle();

        _state(tester).updatePath('Catalog/Component49/Primary');
        await tester.pumpAndSettle();

        expect(_selectedTile, findsNothing);
        expect(_listPosition(tester).pixels, equals(0));
      },
    );

    testWidgets(
      'given a collapsed tree, '
      'when the path is updated from outside the panel, '
      'then the ancestors are expanded and the node is scrolled into view',
      (tester) async {
        _setViewSize(tester, const Size(1200, 800));

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

        expect(find.byType(DesktopLayout), findsOneWidget);
        expect(find.text('DeepComponent'), findsNothing);

        _state(tester).updatePath('Elsewhere/Group/DeepComponent/Hidden');
        await tester.pumpAndSettle();

        expect(find.text('DeepComponent'), findsOneWidget);
        expect(_selectedTile, findsOneWidget);
        expect(_isVisibleInList(tester, _selectedTile), isTrue);
      },
    );

    testWidgets(
      'given a mobile layout with a deep link to a node far down the tree, '
      'when the navigation sheet is opened, '
      'then that node is scrolled into view',
      (tester) async {
        _setViewSize(tester, const Size(400, 800));

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(
              initialRoute: '/?path=Catalog/Component49/Primary',
              components: _components(50),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.findAndTap(find.byIcon(Icons.list_outlined));

        expect(_selectedTile, findsOneWidget);
        expect(_isVisibleInList(tester, _selectedTile), isTrue);
      },
    );
  });
}
