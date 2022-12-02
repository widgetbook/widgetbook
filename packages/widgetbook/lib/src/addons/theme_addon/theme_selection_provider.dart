import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class ThemeSettingProvider<T> extends ValueNotifier<ThemeSetting<T>> {
  ThemeSettingProvider(super.data);

  void tapped(WidgetbookTheme<T> theme) {
    final currentSelection = List<WidgetbookTheme<T>?>.filled(
      value.themes.length,
      null,
      growable: true,
    );

    log('active theme  ${value.activeThemes.first}');
    log('active themes  ${value.activeThemes}');
    log(currentSelection.length.toString());

    currentSelection[0] = value.activeThemes.first;

    // ..addAll(value.activeTextScales.map((e) => e));
    // log('themes length ${value.activeThemes.length}');
    // log('selected themes length ${theme.name}');
    // log('current selection length ${currentSelection.length}');
    // log('current selection data $currentSelection');
    if (currentSelection.contains(theme)) {
      currentSelection.remove(theme);
    } else {
      currentSelection[value.themes.indexOf(theme)] = theme;
      log('index of ${theme.name} ${value.themes.indexOf(theme)}');
      log('current selection  $currentSelection');
      // currentSelection.add(theme);
      // currentSelection.isNotEmpty
      //     ? currentSelection.toList().insert(value.themes.indexOf(theme), theme)
      //     : currentSelection.add(theme);
    }

    value = value.copyWith(activeThemes: currentSelection.toSet());
  }
}
