import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';
import 'helper.dart';

void main() {
  group(
    '$CupertinoThemeAddon',
    () {
      const blueTheme = CupertinoThemeData(
        primaryColor: colorBlue,
      );

      const yellowTheme = CupertinoThemeData(
        primaryColor: colorYellow,
      );

      const blueWidgetbookTheme = WidgetbookTheme<CupertinoThemeData>(
        name: 'Blue',
        data: blueTheme,
      );

      const yellowWidgetbookTheme = WidgetbookTheme(
        name: 'Yellow',
        data: yellowTheme,
      );

      final addon = CupertinoThemeAddon(
        themes: [
          blueWidgetbookTheme,
          yellowWidgetbookTheme,
        ],
      );

      testWidgets(
        'can activate theme',
        (WidgetTester tester) async {
          await testAddon<ThemeSetting<CupertinoThemeData>>(
            tester: tester,
            addon: addon,
            act: () async {
              final dropdownFinder = find.byType(
                DropdownMenu<WidgetbookTheme<CupertinoThemeData>>,
              );
              await tester.tap(dropdownFinder);
              await tester.pumpAndSettle();

              final textFinder = find.byWidgetPredicate(
                (widget) => widget is Text && widget.data == 'Yellow',
              );
              await tester.tap(textFinder.last);
              await tester.pumpAndSettle();
            },
            expect: (setting) => expect(
              setting.activeTheme.data,
              equals(yellowWidgetbookTheme.data),
            ),
          );
        },
      );
    },
  );
}
