import 'package:flutter/cupertino.dart';
import 'package:widgetbook/widgetbook.dart';

class CupertinoThemeSetting extends ThemeSetting<CupertinoThemeData> {
  CupertinoThemeSetting({
    required super.themes,
    required super.activeTheme,
  });

  /// Sets the first theme within `themes` as the active theme on
  /// startup
  factory CupertinoThemeSetting.firstAsSelected({
    required List<WidgetbookTheme<CupertinoThemeData>> themes,
  }) {
    return CupertinoThemeSetting(
      activeTheme: themes.first,
      themes: themes,
    );
  }
}
