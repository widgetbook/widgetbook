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
      const bluetheme = CupertinoThemeData(
        primaryColor: colorBlue,
      );

      const yellowTheme = CupertinoThemeData(
        primaryColor: colorYellow,
      );

      const blueWidgetbookTheme = WidgetbookTheme<CupertinoThemeData>(
        name: 'Blue',
        data: bluetheme,
      );

      const yellowWidgetbookTheme = WidgetbookTheme(
        name: 'Yellow',
        data: yellowTheme,
      );

      final setting = CupertinoThemeSetting(
        activeTheme: blueWidgetbookTheme,
        themes: const [
          blueWidgetbookTheme,
          yellowWidgetbookTheme,
        ],
      );

      final addon = CupertinoThemeAddon(
        setting: setting,
      );

      testWidgets(
        'can access text scale factor via the context',
        (WidgetTester tester) async {
          await testAddon(
            tester: tester,
            addon: addon,
            expect: (context) => expect(
              context.cupertinoTheme,
              equals(blueWidgetbookTheme.data),
            ),
          );
        },
      );

      testWidgets(
        'can activate a text scale factor',
        (WidgetTester tester) async {
          await testAddon(
            tester: tester,
            addon: addon,
            act: (context) async => addon.onChanged(
              context,
              setting.copyWith(activeTheme: yellowWidgetbookTheme),
            ),
            expect: (context) => expect(
              context.cupertinoTheme,
              equals(yellowWidgetbookTheme.data),
            ),
          );
        },
      );

      testWidgets(
        'can activate text scale factor via Widget',
        (WidgetTester tester) async {
          await testAddon(
            tester: tester,
            addon: addon,
            act: (context) async {
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
            expect: (context) => expect(
              context.cupertinoTheme,
              equals(yellowWidgetbookTheme.data),
            ),
          );
        },
      );
    },
  );
}
