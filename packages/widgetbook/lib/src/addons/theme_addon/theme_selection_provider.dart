import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection.dart';

class ThemeSelectionProvider extends ValueNotifier<ThemeSelection> {
  ThemeSelectionProvider(ThemeSelection data) : super(data);

  void tapped(ThemeData locale) {
    final currentSelection = Set<ThemeData>.from(value.activeThemes);
    if (currentSelection.contains(locale)) {
      currentSelection.remove(locale);
    } else {
      currentSelection.add(locale);
    }

    value = value.copyWith(activeThemes: currentSelection);
  }
}
