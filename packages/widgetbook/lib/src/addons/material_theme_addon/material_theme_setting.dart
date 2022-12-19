import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class MaterialThemeSetting extends ThemeSetting<ThemeData> {
  MaterialThemeSetting({
    required super.themes,
    required super.activeTheme,
  });

  /// Sets the first theme within `themes` as the active theme on
  /// startup
  factory MaterialThemeSetting.firstAsSelected({
    required List<WidgetbookTheme<ThemeData>> themes,
  }) {
    return MaterialThemeSetting(
      activeTheme: themes.first,
      themes: themes,
    );
  }
}
