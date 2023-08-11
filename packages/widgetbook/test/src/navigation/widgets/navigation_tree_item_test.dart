import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/src/themes.dart';

import '../../../helper/helper.dart';

void main() {
  group(
    '$NavigationTreeTile',
    () {
      const testNode = NavigationTreeNodeData(
        path: 'test-node',
        name: 'Test Node',
        type: NavigationNodeType.category,
      );

      testWidgets(
        'onTap is executed',
        (tester) async {
          final voidCallbackMock = VoidFnMock();
          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeTile(
              data: testNode,
              onTap: voidCallbackMock.call,
            ),
          );

          await tester.tap(find.byType(InkWell));
          verify(voidCallbackMock.call).called(1);
        },
      );

      testWidgets(
        'more menu icon is initially not rendered',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            const NavigationTreeTile(data: testNode),
          );

          final menuIconFinder = find.byWidgetPredicate(
            (widget) =>
                widget is Icon && widget.icon == Icons.more_vert_rounded,
          );

          expect(menuIconFinder, findsNothing);
        },
      );

      testWidgets(
        "adds indentation SizedBox's from level value",
        (tester) async {
          const level = 2;
          await tester.pumpWidgetWithMaterialApp(
            const NavigationTreeTile(
              data: testNode,
              level: level,
            ),
          );

          final finder = find.byWidgetPredicate(
            (widget) =>
                widget is SizedBox &&
                widget.width == NavigationTreeTile.indentation &&
                widget.height == null,
            description: "SizedBox's with the indentation width",
          );
          expect(finder, findsNWidgets(level + 2));
        },
      );

      testWidgets(
        '$ExpanderIcon is rendered for expandable nodes',
        (tester) async {
          const testNode = NavigationTreeNodeData(
            path: 'category',
            name: 'Category',
            type: NavigationNodeType.category,
          );

          await tester.pumpWidgetWithMaterialApp(
            const NavigationTreeTile(data: testNode),
          );

          expect(testNode.isExpandable, isTrue);
          final finder = find.byType(ExpanderIcon);
          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        '$ExpanderIcon is not rendered for non expandable nodes',
        (tester) async {
          const testNode = NavigationTreeNodeData(
            path: 'use-case',
            name: 'Use Case',
            type: NavigationNodeType.useCase,
          );

          await tester.pumpWidgetWithMaterialApp(
            const NavigationTreeTile(data: testNode),
          );

          expect(testNode.isExpandable, isFalse);
          final finder = find.byType(ExpanderIcon);
          expect(finder, findsNothing);
        },
      );

      testWidgets(
        'renders $ComponentIcon for component navigation node type',
        (tester) async {
          const testNode = NavigationTreeNodeData(
            path: 'component',
            name: 'Component',
            type: NavigationNodeType.component,
          );

          await tester.pumpWidgetWithMaterialApp(
            const NavigationTreeTile(data: testNode),
          );

          final finder = find.byType(ComponentIcon);
          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        'renders $UseCaseIcon for use case navigation node type',
        (tester) async {
          const testNode = NavigationTreeNodeData(
            path: 'use-case',
            name: 'Use Case',
            type: NavigationNodeType.useCase,
          );

          await tester.pumpWidgetWithMaterialApp(
            const NavigationTreeTile(data: testNode),
          );

          final finder = find.byType(UseCaseIcon);
          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        'renders $UseCaseIcon for use case navigation node type',
        (tester) async {
          const testNode = NavigationTreeNodeData(
            path: 'use-case',
            name: 'Use Case',
            type: NavigationNodeType.useCase,
          );

          expect(testNode.isSelectable, isTrue);

          await tester.pumpWidgetWithMaterialApp(
            const NavigationTreeTile(
              data: testNode,
              isSelected: true,
            ),
          );

          final coloredBoxWidgetFinder = find.byWidgetPredicate(
            (widget) => widget is Container && widget.child is InkWell,
          );

          final containerWidget =
              tester.widget(coloredBoxWidgetFinder) as Container;

          expect(
            containerWidget.color,
            Themes.dark.colorScheme.secondaryContainer,
          );
        },
      );
    },
  );
}
