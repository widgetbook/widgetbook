import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/themes.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpWidgetWithMaterialApp(
    Widget widget,
  ) async {
    return pumpWidget(
      MaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.dark,
        home: Scaffold(
          body: widget,
        ),
      ),
    );
  }
}
