import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'localization_setting.freezed.dart';

@freezed
class LocalizationSetting with _$LocalizationSetting {
  factory LocalizationSetting({
    required Locale activeLocale,
    required List<Locale> locales,
    required List<LocalizationsDelegate<dynamic>> localizationsDelegates,
  }) = _LocalizationSetting;

  LocalizationSetting._();
}
