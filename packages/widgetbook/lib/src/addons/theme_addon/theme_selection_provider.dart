import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class ThemeSettingProvider<T> extends ValueNotifier<ThemeSetting<T>> {
  ThemeSettingProvider(super.data);

  void tapped(WidgetbookTheme<T> theme) {
    final currentSelection = value.activeTheme;
    if (currentSelection != theme) {
      value = value.copyWith(activeTheme: theme);
    }
  }
}
