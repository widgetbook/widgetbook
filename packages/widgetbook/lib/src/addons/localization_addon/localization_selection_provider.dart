import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class LocalizationSettingProvider extends ValueNotifier<LocalizationSetting> {
  LocalizationSettingProvider(LocalizationSetting data) : super(data);

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
