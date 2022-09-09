import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class ThemeSettingProvider<T> extends ValueNotifier<ThemeSetting<T>> {
  ThemeSettingProvider(ThemeSetting<T> data) : super(data);

  void tapped(WidgetbookTheme<T> locale) {
    final currentSelection = Set<WidgetbookTheme<T>>.from(value.activeThemes);
    if (currentSelection.contains(locale)) {
      currentSelection.remove(locale);
    } else {
      currentSelection.add(locale);
    }

    value = value.copyWith(activeThemes: currentSelection);
  }
}
