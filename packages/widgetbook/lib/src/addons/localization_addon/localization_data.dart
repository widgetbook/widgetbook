import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'localization_data.freezed.dart';

@freezed
class LocalizationData with _$LocalizationData {
  factory LocalizationData({
    required Locale activeLocale,
    required List<Locale> supportedLocales,
    required List<LocalizationsDelegate<dynamic>> localizationsDelegates,
  }) = _LocalizationData;
}
