import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/layout/desktop_layout.dart';
import 'package:widgetbook/src/layout/mobile_layout.dart';
import 'package:widgetbook/src/layout/responsive_layout.dart';
import 'package:widgetbook/src/next/navigation/navigation_panel.dart';
import 'package:widgetbook/src/settings/settings.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  group(
    '$ResponsiveLayout',
    () {
      testWidgets(
        'given a small screen, '
        'then $DesktopLayout is used',
        (tester) async {
          tester.view.physicalSize = const Size(400, 800);
          tester.view.devicePixelRatio = 1.0;

          await tester.pumpWidget(
            const Widgetbook.material(),
          );

          expect(find.byType(MobileLayout), findsOneWidget);
          expect(find.byType(DesktopLayout), findsNothing);

          addTearDown(tester.view.resetPhysicalSize);
        },
      );

      testWidgets(
        'given a large screen, '
        'then $DesktopLayout is used',
        (tester) async {
          tester.view.physicalSize = const Size(1200, 800);
          tester.view.devicePixelRatio = 1.0;

          await tester.pumpWidget(
            const Widgetbook.material(),
          );

          expect(find.byType(MobileLayout), findsNothing);
          expect(find.byType(DesktopLayout), findsOneWidget);

          addTearDown(tester.view.resetPhysicalSize);
        },
      );

      testWidgets(
        'given a small screen, '
        'when the navigation icon on bottom bar is tapped, '
        'then the $NextNavigationPanel on bottom sheet is displayed',
        (tester) async {
          tester.view.physicalSize = const Size(400, 800);
          tester.view.devicePixelRatio = 1.0;

          await tester.pumpWidget(
            const Widgetbook.material(),
          );

          await tester.tap(find.byIcon(Icons.list_outlined));
          await tester.pumpAndSettle();

          expect(
            find.byType(NextNavigationPanel),
            findsOneWidget,
          );

          addTearDown(tester.view.resetPhysicalSize);
        },
      );

      testWidgets(
        'given a small screen, '
        'when the addons icon on bottom bar is tapped, '
        'then the $MobileSettingsPanel on bottom sheet is displayed',
        (tester) async {
          tester.view.physicalSize = const Size(400, 800);
          tester.view.devicePixelRatio = 1.0;

          await tester.pumpWidget(
            const Widgetbook.material(),
          );

          await tester.tap(find.byIcon(Icons.dashboard_customize_outlined));
          await tester.pumpAndSettle();

          expect(
            find.byType(MobileSettingsPanel),
            findsOneWidget,
          );

          addTearDown(tester.view.resetPhysicalSize);
        },
      );

      testWidgets(
        'given a small screen, '
        'when the knob icon on bottom bar is tapped, '
        'then the $MobileSettingsPanel on bottom sheet is displayed',
        (tester) async {
          tester.view.physicalSize = const Size(400, 800);
          tester.view.devicePixelRatio = 1.0;

          await tester.pumpWidget(
            const Widgetbook.material(),
          );

          await tester.tap(find.byIcon(Icons.tune_outlined));
          await tester.pumpAndSettle();

          expect(
            find.byType(MobileSettingsPanel),
            findsOneWidget,
          );

          addTearDown(tester.view.resetPhysicalSize);
        },
      );
    },
  );
}
