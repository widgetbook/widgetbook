import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../helper/matchers.dart';
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
    super.key,
    required this.data,
    required super.child,
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
    '$ThemeAddon',
    () {
      const blueCustomWidgetbookTheme = WidgetbookTheme<AppThemeData>(
        name: 'Blue',
        data: AppThemeData(color: colorBlue),
      );

      const yellowCustomWidgetbookTheme = WidgetbookTheme<AppThemeData>(
        name: 'Yellow',
        data: AppThemeData(color: colorYellow),
      );

      final addon = ThemeAddon<AppThemeData>(
        themes: [
          blueCustomWidgetbookTheme,
          yellowCustomWidgetbookTheme,
        ],
        themeBuilder: (_, __, ___) => const Placeholder(),
      );

      test(
        'throws assertion if themes are empty',
        () {
          expect(
            () => ThemeAddon(
              themes: [],
              themeBuilder: (_, __, ___) => const Placeholder(),
            ),
            throwsAssertion('themes cannot be empty'),
          );
        },
      );

      testWidgets(
        'can activate theme via Widget',
        (tester) async {
          await testAddon<WidgetbookTheme<AppThemeData>>(
            tester: tester,
            addon: addon,
            act: () async {
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
            expect: (setting) => expect(
              setting.data,
              equals(yellowCustomWidgetbookTheme.data),
            ),
          );
        },
      );
    },
  );
}
