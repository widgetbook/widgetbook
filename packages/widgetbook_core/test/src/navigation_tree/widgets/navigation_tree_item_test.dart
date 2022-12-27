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
      testWidgets(
        'Throws assertion error when both content and label are null',
        (WidgetTester tester) async {
          Future<void> pumpWidget() async {
            await tester.pumpWidgetWithMaterial(
              child: NavigationTreeItem(
                icon: Container(),
              ),
            );
          }

          expect(
            pumpWidget,
            throwsA(isA<AssertionError>()),
          );
        },
      );

      testWidgets(
        'Throws assertion error when both icon and iconData are null',
        (WidgetTester tester) async {
          Future<void> pumpWidget() async {
            await tester.pumpWidgetWithMaterial(
              child: NavigationTreeItem(
                label: 'Label',
              ),
            );
          }

          expect(
            pumpWidget,
            throwsA(isA<AssertionError>()),
          );
        },
      );

      testWidgets(
        'onTap is executed',
        (WidgetTester tester) async {
          final voidCallbackMock = VoidCallbackMock();
          await tester.pumpWidgetWithMaterial(
            child: NavigationTreeItem.component(
              label: 'Label',
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
            child: const NavigationTreeItem.component(
              label: 'Label',
            ),
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
              child: const NavigationTreeItem.component(
                label: 'Label',
              ),
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
              child: NavigationTreeItem.component(
                label: 'Label',
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
            child: const NavigationTreeItem.useCase(
              label: 'Label',
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

      group('Constructor tests', () {
        test(
          '$NavigationTreeItem.category has $Icons.auto_awesome_mosaic icon',
          () {
            const navigationTreeItem = NavigationTreeItem.category(
              label: 'Label',
            );

            expect(navigationTreeItem.iconData, Icons.auto_awesome_mosaic);
          },
        );

        test(
          '$NavigationTreeItem.package has $Icons.inventory icon',
          () {
            const navigationTreeItem = NavigationTreeItem.package(
              label: 'Label',
            );

            expect(navigationTreeItem.iconData, Icons.inventory);
          },
        );

        test(
          '$NavigationTreeItem.folder has $Icons.folder icon',
          () {
            const navigationTreeItem = NavigationTreeItem.folder(
              label: 'Label',
            );

            expect(navigationTreeItem.iconData, Icons.folder);
          },
        );

        test(
          '$NavigationTreeItem.component has $ComponentIcon icon',
          () {
            const navigationTreeItem = NavigationTreeItem.component(
              label: 'Label',
            );

            expect(navigationTreeItem.icon, isA<ComponentIcon>());
          },
        );

        test(
          '$NavigationTreeItem.useCase has $UseCaseIcon icon',
          () {
            const navigationTreeItem = NavigationTreeItem.useCase(
              label: 'Label',
            );

            expect(navigationTreeItem.icon, isA<UseCaseIcon>());
          },
        );
      });
    },
  );
}
