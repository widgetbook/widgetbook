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

    testWidgets(
      'given foldersExpandedByDefault is false, '
      'when the app starts with a deep link to a story, '
      'then only the ancestors of that story are expanded',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(
              foldersExpandedByDefault: false,
              initialRoute: '/?path=Catalog/Group/NestedComponent/Primary',
              components: [
                Component(
                  name: 'NestedComponent',
                  path: 'Catalog/Group',
                  stories: [TestStory(name: 'Primary')],
                ),
                Component(
                  name: 'UnrelatedComponent',
                  path: 'Elsewhere',
                  stories: [TestStory(name: 'Secondary')],
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        final storyInSidebar = find.descendant(
          of: find.byType(FolderTreeTile),
          matching: find.text('Primary'),
        );

        expect(find.text('Catalog'), findsOneWidget);
        expect(find.text('Group'), findsOneWidget);
        expect(find.text('NestedComponent'), findsOneWidget);
        expect(storyInSidebar, findsOneWidget);

        expect(find.text('Elsewhere'), findsOneWidget);
        expect(find.text('UnrelatedComponent'), findsNothing);
        expect(find.text('Secondary'), findsNothing);

        addTearDown(tester.view.resetPhysicalSize);
      },
    );

    testWidgets(
      'given foldersExpandedByDefault is false, '
      'when the app starts with a deep link to a scenario, '
      'then the story node is expanded to reveal the scenario',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          WidgetbookApp(
            config: Config(
              foldersExpandedByDefault: false,
              initialRoute: '/?path=Catalog/NestedComponent/Primary/Dark',
              components: [
                Component(
                  name: 'NestedComponent',
                  path: 'Catalog',
                  stories: [
                    TestStory(
                      name: 'Primary',
                      scenarios: [TestScenario(name: 'Dark')],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        final scenarioInSidebar = find.descendant(
          of: find.byType(FolderTreeTile),
          matching: find.text('Dark'),
        );

        expect(scenarioInSidebar, findsOneWidget);

        addTearDown(tester.view.resetPhysicalSize);
      },
    );
  });
}
