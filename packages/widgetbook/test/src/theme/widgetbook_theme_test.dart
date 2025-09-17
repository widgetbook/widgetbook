import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/src/state/default_home_page.dart';
import 'package:widgetbook/src/theme/theme.dart';
import 'package:widgetbook/src/widgetbook_app.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

void main() {
  group('$WidgetbookTheme', () {
    testWidgets(
      'given the $WidgetbookApp, '
      'then the $WidgetbookTheme is accessible',
      (tester) async {
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
      },
    );
  });
}
