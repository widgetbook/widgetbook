import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'localization_state.freezed.dart';

@freezed
class LocalizationState with _$LocalizationState {
  factory LocalizationState({
    List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  }) = _LocalizationState;
}
