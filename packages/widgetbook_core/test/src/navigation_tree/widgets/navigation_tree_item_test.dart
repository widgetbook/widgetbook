import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/callback_mock.dart';
import '../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$NavigationTreeItem',
    () {
      const testNode = NavigationTreeNodeData(
        path: 'test-node',
        name: 'Test Node',
        type: NavigationNodeType.category,
      );

      testWidgets(
        'onTap is executed',
        (WidgetTester tester) async {
          final voidCallbackMock = VoidCallbackMock();
          await tester.pumpWidgetWithMaterial(
            child: NavigationTreeItem(
              data: testNode,
              onTap: voidCallbackMock,
            ),
          );

          await tester.tap(find.byType(InkWell));
          verify(voidCallbackMock.call).called(1);
        },
      );

      testWidgets(
        'more menu icon is initially not rendered',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterial(
            child: const NavigationTreeItem(data: testNode),
          );

          final menuIconFinder = find.byWidgetPredicate(
            (widget) =>
                widget is Icon && widget.icon == Icons.more_vert_rounded,
          );

          expect(menuIconFinder, findsNothing);
        },
      );

      group('More menu icon tests', () {
        testWidgets(
          'MouseRegion onEnter and onExit callbacks toggle more menu icon',
          (WidgetTester tester) async {
            await tester.pumpWidgetWithMaterial(
              child: const NavigationTreeItem(data: testNode),
            );

            final menuIconFinder = find.byWidgetPredicate(
              (widget) =>
                  widget is Icon && widget.icon == Icons.more_vert_rounded,
            );

            expect(menuIconFinder, findsNothing);

            final gesture = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );
            await gesture.addPointer(location: Offset.zero);
            addTearDown(gesture.removePointer);
            await tester.pump();

            await gesture.moveTo(tester.getCenter(find.byType(InkWell).first));
            await tester.pumpAndSettle();
            expect(menuIconFinder, findsOneWidget);

            await gesture.moveTo(
              tester.getBottomLeft(find.byType(InkWell).first) +
                  const Offset(-10, 0),
            );
            await tester.pumpAndSettle();
            expect(menuIconFinder, findsNothing);
          },
        );

        testWidgets(
          'onMoreIconPressed is called',
          (WidgetTester tester) async {
            final voidCallbackMock = VoidCallbackMock();
            await tester.pumpWidgetWithMaterial(
              child: NavigationTreeItem(
                data: testNode,
                onMoreIconPressed: voidCallbackMock,
              ),
            );

            final menuIconFinder = find.byWidgetPredicate(
              (widget) =>
                  widget is Icon && widget.icon == Icons.more_vert_rounded,
            );
            final gesture = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );
            await gesture.addPointer(location: Offset.zero);
            addTearDown(gesture.removePointer);
            await gesture.moveTo(tester.getCenter(find.byType(InkWell).first));
            await tester.pumpAndSettle();
            expect(menuIconFinder, findsOneWidget);

            await tester.tap(menuIconFinder);

            verify(voidCallbackMock.call).called(1);
          },
        );
      });

      testWidgets(
        "adds indentation SizedBox's from level value",
        (WidgetTester tester) async {
          const level = 2;
          await tester.pumpWidgetWithMaterial(
            child: const NavigationTreeItem(
              data: testNode,
              level: level,
            ),
          );

          final finder = find.byWidgetPredicate(
            (Widget widget) =>
                widget is SizedBox &&
                widget.width == NavigationTreeItem.indentation &&
                widget.height == null,
            description: "SizedBox's with the indentation width",
          );
          expect(finder, findsNWidgets(level + 2));
        },
      );

      testWidgets(
        '$ExpanderIcon is rendered for expandable nodes',
        (WidgetTester tester) async {
          const testNode = NavigationTreeNodeData(
            path: 'category',
            name: 'Category',
            type: NavigationNodeType.category,
          );

          await tester.pumpWidgetWithMaterial(
            child: const NavigationTreeItem(data: testNode),
          );

          expect(testNode.isExpandable, isTrue);
          final finder = find.byType(ExpanderIcon);
          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        '$ExpanderIcon is not rendered for non expandable nodes',
        (WidgetTester tester) async {
          const testNode = NavigationTreeNodeData(
            path: 'use-case',
            name: 'Use Case',
            type: NavigationNodeType.useCase,
          );

          await tester.pumpWidgetWithMaterial(
            child: const NavigationTreeItem(data: testNode),
          );

          expect(testNode.isExpandable, isFalse);
          final finder = find.byType(ExpanderIcon);
          expect(finder, findsNothing);
        },
      );

      testWidgets(
        'renders $ComponentIcon for component navigation node type',
        (WidgetTester tester) async {
          const testNode = NavigationTreeNodeData(
            path: 'component',
            name: 'Component',
            type: NavigationNodeType.component,
          );

          await tester.pumpWidgetWithMaterial(
            child: const NavigationTreeItem(data: testNode),
          );

          final finder = find.byType(ComponentIcon);
          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        'renders $UseCaseIcon for use case navigation node type',
        (WidgetTester tester) async {
          const testNode = NavigationTreeNodeData(
            path: 'use-case',
            name: 'Use Case',
            type: NavigationNodeType.useCase,
          );

          await tester.pumpWidgetWithMaterial(
            child: const NavigationTreeItem(data: testNode),
          );

          final finder = find.byType(UseCaseIcon);
          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        'renders $UseCaseIcon for use case navigation node type',
        (WidgetTester tester) async {
          const testNode = NavigationTreeNodeData(
            path: 'use-case',
            name: 'Use Case',
            type: NavigationNodeType.useCase,
          );

          expect(testNode.isSelectable, isTrue);

          await tester.pumpWidgetWithMaterial(
            child: const NavigationTreeItem(
              data: testNode,
              isSelected: true,
            ),
          );

          final coloredBoxWidgetFinder = find.byWidgetPredicate(
            (Widget widget) => widget is ColoredBox && widget.child is InkWell,
          );

          final coloredBoxWidget =
              tester.widget(coloredBoxWidgetFinder) as ColoredBox;

          expect(
            coloredBoxWidget.color,
            Themes.dark.colorScheme.secondaryContainer,
          );
        },
      );
    },
  );
}
