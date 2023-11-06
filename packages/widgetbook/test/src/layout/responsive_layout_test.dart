import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/layout/desktop_layout.dart';
import 'package:widgetbook/src/layout/mobile_layout.dart';
import 'package:widgetbook/src/layout/responsive_layout.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/src/routing/routing.dart';
import 'package:widgetbook/src/settings/settings.dart';
import 'package:widgetbook/src/state/state.dart';

void main() {
  group(
    '$ResponsiveLayout',
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

          expect(find.byType(MobileLayout), findsOneWidget);
          expect(find.byType(DesktopLayout), findsNothing);

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

          expect(find.byType(MobileLayout), findsNothing);
          expect(find.byType(DesktopLayout), findsOneWidget);

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

          await tester.tap(find.byIcon(Icons.list_outlined));
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

          await tester.tap(find.byIcon(Icons.dashboard_customize_outlined));
          await tester.pumpAndSettle();

          expect(
            find.byType(SettingsPanel),
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

          await tester.tap(find.byIcon(Icons.tune_outlined));
          await tester.pumpAndSettle();

          expect(
            find.byType(SettingsPanel),
            findsOneWidget,
          );

          addTearDown(tester.view.resetPhysicalSize);
        },
      );
    },
  );
}
