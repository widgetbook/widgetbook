import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection.dart';
import 'package:widgetbook/widgetbook.dart';

class ThemeSelectionProvider<T> extends ValueNotifier<ThemeSelection<T>> {
  ThemeSelectionProvider(ThemeSelection<T> data) : super(data);

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
