import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/src/themes.dart';

import '../../../helper/callback_mock.dart';
import '../../../helper/widget_test_helper.dart';

void main() {
  group(
    '$NavigationTreeItem',
    () {
      final testNode = WidgetbookCategory(
        name: 'category',
        children: [],
      );

      testWidgets(
        'onTap is executed',
        (tester) async {
          final voidCallbackMock = VoidCallbackMock();
          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeItem(
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
            NavigationTreeItem(
              data: testNode,
            ),
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
            NavigationTreeItem(
              data: testNode,
              level: level,
            ),
          );

          final finder = find.byWidgetPredicate(
            (widget) =>
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
        (tester) async {
          final testNode = WidgetbookCategory(
            name: 'category',
            children: [],
          );

          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeItem(
              data: testNode,
            ),
          );

          expect(testNode.isExpandable, isTrue);
          final finder = find.byType(ExpanderIcon);
          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        '$ExpanderIcon is not rendered for non expandable nodes',
        (tester) async {
          final testNode = WidgetbookUseCase(
            name: 'use-case',
            builder: (_) => const SizedBox.shrink(),
          );

          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeItem(
              data: testNode,
            ),
          );

          expect(testNode.isExpandable, isFalse);
          final finder = find.byType(ExpanderIcon);
          expect(finder, findsNothing);
        },
      );

      testWidgets(
        '$ExpanderIcon is not rendered for selectable nodes',
        (tester) async {
          final testNode = WidgetbookUseCase(
            name: 'use-case',
            builder: (_) => const SizedBox.shrink(),
          );

          expect(testNode.isSelectable, isTrue);

          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeItem(
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
