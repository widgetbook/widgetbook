import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/navigation/navigation.dart';
import 'package:widgetbook/src/core/widgetbook_app.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group('$NavigationPanel', () {
    testWidgets(
      'given a component in desktop mode, '
      'when entering a matching query in search, '
      'then the matching entry is visible in the sidebar',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(
              components: [
                Component(
                  name: 'SearchableComponent',
                  path: 'Catalog',
                  stories: [TestStory(name: 'Primary')],
                ),
              ],
            ),
          ),
        );

        final componentInSidebar = find.descendant(
          of: find.byType(FolderTreeTile),
          matching: find.text('SearchableComponent'),
        );

        expect(componentInSidebar, findsOneWidget);

        await tester.findAndEnter(
          find.byType(TextFormField),
          'Search',
        );

        expect(componentInSidebar, findsOneWidget);
      },
    );

    testWidgets(
      'given a component in desktop mode, '
      'when entering a non-matching query in search, '
      'then a no-matches message is shown',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(
              components: [
                Component(
                  name: 'SearchableComponent',
                  path: 'Catalog',
                  stories: [TestStory(name: 'Primary')],
                ),
              ],
            ),
          ),
        );

        final componentInSidebar = find.descendant(
          of: find.byType(FolderTreeTile),
          matching: find.text('SearchableComponent'),
        );

        expect(componentInSidebar, findsOneWidget);

        await tester.findAndEnter(
          find.byType(TextFormField),
          'DoesNotExist',
        );

        expect(find.text('No matches found'), findsOneWidget);
        expect(componentInSidebar, findsNothing);
      },
    );
    testWidgets(
      'given foldersExpandedByDefault is false, '
      'when the navigation panel is shown, '
      'then nested entries are hidden until expanded',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(
              foldersExpandedByDefault: false,
              components: [
                Component(
                  name: 'NestedComponent',
                  path: 'Catalog/Group',
                  stories: [TestStory(name: 'Primary')],
                ),
              ],
            ),
          ),
        );

        expect(find.text('NestedComponent'), findsNothing);
        expect(find.text('Catalog'), findsOneWidget);

        await tester.tap(find.text('Catalog'));
        await tester.pumpAndSettle();

        expect(find.text('Group'), findsOneWidget);
        expect(find.text('NestedComponent'), findsNothing);

        await tester.tap(find.text('Group'));
        await tester.pumpAndSettle();

        expect(find.text('NestedComponent'), findsOneWidget);
      },
    );
  });
}
