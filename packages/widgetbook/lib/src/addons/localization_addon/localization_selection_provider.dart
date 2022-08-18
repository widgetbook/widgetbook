import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_selection.dart';

class LocalizationSelectionProvider
    extends ValueNotifier<LocalizationSelection> {
  LocalizationSelectionProvider(LocalizationSelection data) : super(data);

  void tapped(Locale locale) {
    final currentSelection = Set<Locale>.from(value.activeLocales);
    if (currentSelection.contains(locale)) {
      currentSelection.remove(locale);
    } else {
      currentSelection.add(locale);
    }

    value = value.copyWith(activeLocales: currentSelection);
  }
}
