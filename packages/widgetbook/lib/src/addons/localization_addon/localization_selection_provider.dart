import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class LocalizationSettingProvider extends ValueNotifier<LocalizationSetting> {
  LocalizationSettingProvider(super.data);

  void tapped(Locale locale) {
    final currentSelection = value.activeLocale;
    if (currentSelection != locale) {
      value = value.copyWith(activeLocale: locale);
    }
  }
}
