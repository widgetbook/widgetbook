import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class ThemeSettingProvider<T> extends ValueNotifier<ThemeSetting<T>> {
  ThemeSettingProvider(super.data);

  void tapped(WidgetbookTheme<T> theme) {
    final currentSelection = Set<WidgetbookTheme<T>>.from(value.activeThemes);
    if (currentSelection.contains(theme)) {
      currentSelection.remove(theme);
    } else {
      currentSelection.add(theme);
    }

    value = value.copyWith(activeThemes: currentSelection);
  }
}
