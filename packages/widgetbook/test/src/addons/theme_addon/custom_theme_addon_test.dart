import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';
import 'helper.dart';

class AppThemeData {
  const AppThemeData({
    required this.color,
  });
  final Color color;
}

class AppTheme extends InheritedWidget {
  const AppTheme({
    required this.data,
    required super.child,
    super.key,
  });

  final AppThemeData data;

  static AppThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    return widget!.data;
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return data != oldWidget.data;
  }
}

void main() {
  group(
    '$CustomThemeAddon',
    () {
      const blueCustomWidgetbookTheme = WidgetbookTheme<AppThemeData>(
        name: 'Blue',
        data: AppThemeData(color: colorBlue),
      );

      const yellowCustomWidgetbookTheme = WidgetbookTheme<AppThemeData>(
        name: 'Yellow',
        data: AppThemeData(color: colorYellow),
      );

      const themes = [
        blueCustomWidgetbookTheme,
        yellowCustomWidgetbookTheme,
      ];
      final setting = ThemeSetting<AppThemeData>.firstAsSelected(
        themes: themes,
      );
      final addon = CustomThemeAddon<AppThemeData>(
        setting: setting,
      );

      testWidgets(
        'can access text scale factor via the context',
        (WidgetTester tester) async {
          await testAddon(
            tester: tester,
            addon: addon,
            expect: (context) => expect(
              context.theme<AppThemeData>(),
              equals(blueCustomWidgetbookTheme.data),
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
              setting.copyWith(activeTheme: yellowCustomWidgetbookTheme),
            ),
            expect: (context) => expect(
              context.theme<AppThemeData>(),
              equals(yellowCustomWidgetbookTheme.data),
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
                DropdownMenu<WidgetbookTheme<AppThemeData>>,
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
              context.theme<AppThemeData>(),
              equals(yellowCustomWidgetbookTheme.data),
            ),
          );
        },
      );
    },
  );
}
