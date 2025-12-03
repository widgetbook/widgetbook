import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/navigation/navigation.dart';
import 'package:widgetbook/src/core/state/default_home_page.dart';
import 'package:widgetbook/src/core/theme/theme.dart';
import 'package:widgetbook/src/core/widgetbook_app.dart';
import 'package:widgetbook/src/core/workbench/workbench.dart';

void main() {
  group('$WidgetbookTheme', () {
    testWidgets(
      'given the $WidgetbookApp, '
      'then the $WidgetbookTheme is accessible',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const WidgetbookApp(),
        );

        expect(
          WidgetbookTheme.maybeOf(tester.element(find.byType(DefaultHomePage))),
          isA<ThemeData>(),
        );

        expect(
          WidgetbookTheme.maybeOf(tester.element(find.byType(Workbench))),
          isA<ThemeData>(),
        );

        expect(
          WidgetbookTheme.maybeOf(tester.element(find.byType(NavigationPanel))),
          isA<ThemeData>(),
        );

        expect(
          WidgetbookTheme.maybeOf(tester.element(find.byType(TabBarView))),
          isA<ThemeData>(),
        );

        addTearDown(tester.view.resetPhysicalSize);
      },
    );
  });
}
