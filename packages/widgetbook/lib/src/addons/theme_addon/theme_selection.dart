import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/widgetbook.dart';

part 'theme_selection.freezed.dart';

@freezed
class ThemeSelection<T> with _$ThemeSelection<T> {
  factory ThemeSelection({
    required List<WidgetbookTheme<T>> themes,
    required Set<WidgetbookTheme<T>> activeThemes,
  }) = _ThemeSelection;
}
