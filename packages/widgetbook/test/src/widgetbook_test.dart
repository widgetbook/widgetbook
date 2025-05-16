import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/src/settings/settings.dart';
import 'package:widgetbook/src/state/default_home_page.dart';
import 'package:widgetbook/src/widgetbook_theme.dart';
import 'package:widgetbook/src/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart' hide WidgetbookTheme;

import '../helper/helper.dart';

void main() {
  group('Widgetbook', () {
    testWidgets(
      'given a header in desktop mode, '
      'then it appears in the NavigationPanel',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const Widgetbook.material(
            header: Placeholder(),
            directories: [],
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(Placeholder), findsOneWidget);

        addTearDown(tester.view.resetPhysicalSize);
      },
    );

    testWidgets(
      'given a header in mobile mode, '
      'when clicking on the bottom navigation bar,'
      'then the header appears in the NavigationPanel',
      (tester) async {
        tester.view.physicalSize = const Size(640, 1200);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const Widgetbook.material(
            header: Placeholder(),
            directories: [],
          ),
        );

        await tester.pumpAndSettle();
        await tester.findAndTap(find.text('Navigation'));

        expect(find.byType(Placeholder), findsOneWidget);

        addTearDown(tester.view.resetPhysicalSize);
      },
    );

    testWidgets(
      'given the widgetbook application'
      'then the widgetbook theme is accessible',
      (tester) async {
        await tester.pumpWidget(
          const Widgetbook.material(
            directories: [],
          ),
        );

        expect(
          WidgetbookTheme.maybeOf(
            tester.element(find.byType(DefaultHomePage)),
          ),
          isA<ThemeData>(),
          reason: 'The home page should be able to access the widgetbook theme',
        );
        expect(
          WidgetbookTheme.maybeOf(
            tester.element(find.byType(Workbench)),
          ),
          isA<ThemeData>(),
          reason: 'The workbench should be able to access the widgetbook theme',
        );

        expect(
          WidgetbookTheme.maybeOf(
            tester.element(find.byType(NavigationPanel)),
          ),
          isA<ThemeData>(),
          reason:
              'The navigation panel should be able to access the widgetbook theme',
        );
        expect(
          WidgetbookTheme.maybeOf(
            tester.element(find.byType(SettingsPanel)),
          ),
          isA<ThemeData>(),
          reason:
              'The settings panel should be able to access the widgetbook theme',
        );
      },
    );
  });
}
