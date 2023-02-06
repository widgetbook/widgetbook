import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/src/themes/themes.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpWidgetWithMaterial({
    required Widget child,
  }) {
    return pumpWidget(
      MaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.dark,
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }
}
