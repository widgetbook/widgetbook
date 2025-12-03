import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/layout/desktop_layout.dart';
import 'package:widgetbook/src/core/navigation/navigation.dart';
import 'package:widgetbook/src/core/widgetbook_app.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  group(
    '$DesktopLayout',
    () {
      testWidgets(
        'given an empty panels query parameter, '
        'then navigation and settings panels are not displayed',
        (tester) async {
          tester.view.physicalSize = const Size(1200, 800);
          tester.view.devicePixelRatio = 1.0;

          await tester.pumpWidget(
            const WidgetbookApp(
              config: Config(
                initialRoute: '?panels=',
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(NavigationPanel), findsNothing);
          expect(find.byType(TabBarView), findsNothing);

          addTearDown(tester.view.resetPhysicalSize);
        },
      );

      testWidgets(
        'given a panels query parameter with no navigation, '
        'then navigation panel is not displayed',
        (tester) async {
          tester.view.physicalSize = const Size(1200, 800);
          tester.view.devicePixelRatio = 1.0;

          await tester.pumpWidget(
            const WidgetbookApp(
              config: Config(
                initialRoute: '?panels=addons,args',
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(NavigationPanel), findsNothing);

          addTearDown(tester.view.resetPhysicalSize);
        },
      );

      testWidgets(
        'given a panels query parameter with no addons or args, '
        'then settings panel is not displayed',
        (tester) async {
          tester.view.physicalSize = const Size(1200, 800);
          tester.view.devicePixelRatio = 1.0;

          await tester.pumpWidget(
            const WidgetbookApp(
              config: Config(
                initialRoute: '?panels=navigation',
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(TabBarView), findsNothing);

          addTearDown(tester.view.resetPhysicalSize);
        },
      );

      testWidgets(
        'given a panels query parameter with no addons, '
        'then addons tab in settings panel is not displayed',
        (tester) async {
          tester.view.physicalSize = const Size(1200, 800);
          tester.view.devicePixelRatio = 1.0;

          await tester.pumpWidget(
            const WidgetbookApp(
              config: Config(
                initialRoute: '?panels=args',
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.text('Addons'), findsNothing);

          addTearDown(tester.view.resetPhysicalSize);
        },
      );

      testWidgets(
        'given a panels query parameter with no args, '
        'then args tab in settings panel is not displayed',
        (tester) async {
          tester.view.physicalSize = const Size(1200, 800);
          tester.view.devicePixelRatio = 1.0;

          await tester.pumpWidget(
            const WidgetbookApp(
              config: Config(
                initialRoute: '?panels=addons',
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.text('Args'), findsNothing);

          addTearDown(tester.view.resetPhysicalSize);
        },
      );
    },
  );
}
