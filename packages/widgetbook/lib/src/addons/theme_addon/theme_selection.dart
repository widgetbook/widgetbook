import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_selection.freezed.dart';

@freezed
class ThemeSelection with _$ThemeSelection {
  factory ThemeSelection({
    required List<ThemeData> themes,
    required Set<ThemeData> activeThemes,
  }) = _ThemeSelection;
}
