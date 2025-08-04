import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

class AppThemeData {
  const AppThemeData(this.color);

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
      const blueTheme = const WidgetbookTheme(
        name: 'Blue Theme',
        data: AppThemeData(Colors.blue),
      );

      const yellowTheme = const WidgetbookTheme(
        name: 'Yellow Theme',
        data: AppThemeData(Colors.yellow),
      );

      final addon = ThemeAddon<AppThemeData>(
        themes: [blueTheme, yellowTheme],
        themeBuilder:
            (_, data, child) => AppTheme(
              data: data,
              child: child,
            ),
      );

      test(
        'given a query group, '
        'then [valueFromQueryGroup] can parse the value',
        () {
          final result = addon.valueFromQueryGroup({
            'name': yellowTheme.name,
          });

          expect(result, equals(yellowTheme));
        },
      );

      testWidgets(
        'given theme setting, '
        'then [buildUseCase] wraps child with [AppTheme] widget',
        (tester) async {
          await tester.pumpWidgetWithBuilder(
            (context) => addon.buildUseCase(
              context,
              const Text('child'),
              yellowTheme,
            ),
          );

          final result = AppTheme.of(
            tester.element(find.text('child')),
          );

          expect(
            result,
            equals(yellowTheme.data),
          );
        },
      );
    },
  );
}
