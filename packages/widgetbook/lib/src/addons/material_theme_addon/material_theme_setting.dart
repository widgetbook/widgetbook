import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class MaterialThemeSetting extends ThemeSetting<ThemeData> {
  MaterialThemeSetting({
    required super.themes,
    required super.activeThemes,
  });

  /// Sets the first theme within `themes` as the active theme on
  /// startup
  factory MaterialThemeSetting.firstAsSelected({
    required List<WidgetbookTheme<ThemeData>> themes,
  }) {
    return MaterialThemeSetting(
      activeThemes: themes.take(1).toSet(),
      themes: themes,
    );
  }

  /// Sets all `themes` as the active themes on
  /// startup
  factory MaterialThemeSetting.allAsSelected({
    required List<WidgetbookTheme<ThemeData>> themes,
  }) {
    return MaterialThemeSetting(
      activeThemes: themes.toSet(),
      themes: themes,
    );
  }
}
