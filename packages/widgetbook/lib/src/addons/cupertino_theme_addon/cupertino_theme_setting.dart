import 'package:flutter/cupertino.dart';
import 'package:widgetbook/widgetbook.dart';

class CupertinoThemeSetting extends ThemeSetting<CupertinoThemeData> {
  CupertinoThemeSetting({
    required super.themes,
    required super.activeThemes,
  });

  /// Sets the first theme within `themes` as the active theme on
  /// startup
  factory CupertinoThemeSetting.firstAsSelected({
    required List<WidgetbookTheme<CupertinoThemeData>> themes,
  }) {
    return CupertinoThemeSetting(
      activeThemes: themes.take(1).toSet(),
      themes: themes,
    );
  }

  /// Sets all `themes` as the active themes on
  /// startup
  factory CupertinoThemeSetting.allAsSelected({
    required List<WidgetbookTheme<CupertinoThemeData>> themes,
  }) {
    return CupertinoThemeSetting(
      activeThemes: themes.toSet(),
      themes: themes,
    );
  }
}
