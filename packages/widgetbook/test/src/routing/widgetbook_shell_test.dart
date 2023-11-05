import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/src/routing/routing.dart';
import 'package:widgetbook/src/settings/settings.dart';
import 'package:widgetbook/src/state/state.dart';

void main() {
  group(
    '$WidgetbookShell',
    () {
      testWidgets(
        'given a small screen, '
        'then MobileWidgetbookShell is used',
        (tester) async {
          tester.view.physicalSize = const Size(400, 800);
          tester.view.devicePixelRatio = 1.0;

          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            root: WidgetbookRoot(children: []),
          );

          final router = AppRouter(
            state: state,
          );

          await tester.pumpWidget(
            WidgetbookScope(
              state: state,
              child: MaterialApp.router(
                routerConfig: router,
              ),
            ),
          );

          expect(find.byType(MobileWidgetbookShell), findsOneWidget);
          expect(find.byType(DesktopWidgetbookShell), findsNothing);

          addTearDown(tester.view.resetPhysicalSize);
        },
      );

      testWidgets(
        'given a large screen, '
        'then DesktopWidgetbookShell is used',
        (tester) async {
          tester.view.physicalSize = const Size(1200, 800);
          tester.view.devicePixelRatio = 1.0;

          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            root: WidgetbookRoot(children: []),
          );

          final router = AppRouter(
            state: state,
          );

          await tester.pumpWidget(
            WidgetbookScope(
              state: state,
              child: MaterialApp.router(
                routerConfig: router,
              ),
            ),
          );

          expect(find.byType(MobileWidgetbookShell), findsNothing);
          expect(find.byType(DesktopWidgetbookShell), findsOneWidget);

          addTearDown(tester.view.resetPhysicalSize);
        },
      );

      testWidgets(
        'given a small screen, '
        'when the navigation icon on bottom bar is tapped, '
        'then the navigation panel on bottom sheet is displayed',
        (tester) async {
          tester.view.physicalSize = const Size(400, 800);
          tester.view.devicePixelRatio = 1.0;

          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            addons: [],
            root: WidgetbookRoot(
              children: [
                WidgetbookFolder(
                  name: 'Widgets',
                  children: [],
                ),
              ],
            ),
          );

          final router = AppRouter(
            state: state,
          );

          await tester.pumpWidget(
            WidgetbookScope(
              state: state,
              child: MaterialApp.router(
                routerConfig: router,
              ),
            ),
          );

          await tester.tap(find.byIcon(Icons.navigation));
          await tester.pumpAndSettle();

          expect(find.byType(NavigationPanel), findsOneWidget);

          addTearDown(tester.view.resetPhysicalSize);
        },
      );

      testWidgets(
        'given a small screen, '
        'when the addons icon on bottom bar is tapped, '
        'then the settings panel on bottom sheet is displayed',
        (tester) async {
          tester.view.physicalSize = const Size(400, 800);
          tester.view.devicePixelRatio = 1.0;

          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            root: WidgetbookRoot(
              children: [
                WidgetbookFolder(
                  name: 'Widgets',
                  children: [],
                ),
              ],
            ),
          );

          final router = AppRouter(
            state: state,
          );

          await tester.pumpWidget(
            WidgetbookScope(
              state: state,
              child: MaterialApp.router(
                routerConfig: router,
              ),
            ),
          );

          await tester.tap(find.byIcon(Icons.add));
          await tester.pumpAndSettle();

          expect(
            find.byType(SettingsPanel, skipOffstage: false),
            findsOneWidget,
          );

          addTearDown(tester.view.resetPhysicalSize);
        },
      );

      testWidgets(
        'given a small screen, '
        'when the knob icon on bottom bar is tapped, '
        'then the settings panel on bottom sheet is displayed',
        (tester) async {
          tester.view.physicalSize = const Size(400, 800);
          tester.view.devicePixelRatio = 1.0;

          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            root: WidgetbookRoot(
              children: [
                WidgetbookFolder(
                  name: 'Widgets',
                  children: [],
                ),
              ],
            ),
          );

          final router = AppRouter(
            state: state,
          );

          await tester.pumpWidget(
            WidgetbookScope(
              state: state,
              child: MaterialApp.router(
                routerConfig: router,
              ),
            ),
          );

          await tester.tap(find.byIcon(Icons.settings));
          await tester.pumpAndSettle();

          expect(
            find.byType(SettingsPanel, skipOffstage: false),
            findsOneWidget,
          );

          addTearDown(tester.view.resetPhysicalSize);
        },
      );

      testWidgets(
        'given a small screen, '
        'when a four-finger tap is performed, '
        'then the bottom bar visibility is toggled',
        (tester) async {
          tester.view.physicalSize = const Size(400, 800);
          tester.view.devicePixelRatio = 1.0;

          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            root: WidgetbookRoot(
              children: [
                WidgetbookFolder(
                  name: 'Widgets',
                  children: [],
                ),
              ],
            ),
          );

          final router = AppRouter(
            state: state,
          );

          await tester.pumpWidget(
            WidgetbookScope(
              state: state,
              child: MaterialApp.router(
                routerConfig: router,
              ),
            ),
          );

          final mobileShellState =
              tester.state(find.byType(MobileWidgetbookShell))
                  as MobileWidgetbookShellState;

          expect(mobileShellState.isBottomBarVisible, isTrue);

          final pointerDownEvent = const PointerDownEvent(
            pointer: 1,
            device: 1,
          );

          final pointerUpEvent = const PointerUpEvent(
            pointer: 1,
            device: 1,
          );

          mobileShellState.handlePointerDown(pointerDownEvent);
          mobileShellState.handlePointerDown(pointerDownEvent);
          mobileShellState.handlePointerDown(pointerDownEvent);
          mobileShellState.handlePointerDown(pointerDownEvent);

          expect(mobileShellState.isBottomBarVisible, isFalse);

          mobileShellState.handlePointerUp(pointerUpEvent);
          mobileShellState.handlePointerUp(pointerUpEvent);
          mobileShellState.handlePointerUp(pointerUpEvent);
          mobileShellState.handlePointerUp(pointerUpEvent);

          expect(mobileShellState.isBottomBarVisible, isTrue);

          addTearDown(tester.view.resetPhysicalSize);
        },
      );
    },
  );
}
