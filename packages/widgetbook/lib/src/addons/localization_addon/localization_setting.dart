import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

part 'localization_setting.freezed.dart';

@freezed
class LocalizationSetting extends WidgetbookAddOnModel<LocalizationSetting>
    with _$LocalizationSetting {
  factory LocalizationSetting({
    required Locale activeLocale,
    required List<Locale> locales,
    required List<LocalizationsDelegate<dynamic>> localizationsDelegates,
  }) = _LocalizationSetting;

  LocalizationSetting._();

  @override
  Map<String, String> toMap() {
    return {
      'locale': activeLocale.toLanguageTag(),
    };
  }

  @override
  LocalizationSetting fromMap(Map<String, String> map) {
    return this.copyWith(
      activeLocale: locales.firstWhere(
        (locale) => locale.toLanguageTag() == map['locale'],
        orElse: () => activeLocale,
      ),
    );
  }
}
