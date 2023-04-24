import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

part 'localization_setting.freezed.dart';

@freezed
class LocalizationSetting extends WidgetbookAddOnModel<LocalizationSetting>
    with _$LocalizationSetting {
  @Assert('locales.isNotEmpty', 'locales cannot be empty')
  factory LocalizationSetting({
    required Locale activeLocale,
    required List<Locale> locales,
    required List<LocalizationsDelegate<dynamic>> localizationsDelegates,
  }) = _LocalizationSetting;

  @override
  Map<String, String> toQueryParameter() {
    return {
      'locale': activeLocale.toLanguageTag(),
    };
  }

  @override
  LocalizationSetting? fromQueryParameter(Map<String, String> queryParameters) {
    return queryParameters.containsKey('locale')
        ? this.copyWith(
            activeLocale: locales.firstWhere(
              (locale) => locale.toLanguageTag() == queryParameters['locale']!,
            ),
          )
        : null;
  }
}
