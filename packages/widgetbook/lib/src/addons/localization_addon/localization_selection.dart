import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'localization_selection.freezed.dart';

@freezed
class LocalizationSelection with _$LocalizationSelection {
  factory LocalizationSelection({
    required Set<Locale> activeLocales,
    required List<Locale> locales,
    required List<LocalizationsDelegate<dynamic>> localizationsDelegates,
  }) = _LocalizationSelection;
}
