import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/themes.dart';

extension TesterExtension on WidgetTester {
  /// Wraps [widget] with a [MaterialApp] predefined with [Themes]
  Future<void> pumpWidgetWithMaterialApp(Widget widget) async {
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

  /// Same as [pumpWidgetWithMaterialApp] but with a [BuildContext].
  Future<void> pumpWidgetWithBuilder(WidgetBuilder builder) async {
    return pumpWidget(
      MaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.dark,
        home: Scaffold(
          body: Builder(
            builder: builder,
          ),
        ),
      ),
    );
  }

  /// Executes [tap] on the [finder] then [pumpAndSettle].
  Future<Finder> findAndTap(Finder finder) async {
    await tap(finder);
    await pumpAndSettle();
    return finder;
  }
}
