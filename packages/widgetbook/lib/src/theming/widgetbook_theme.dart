import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'widgetbook_theme.freezed.dart';

@freezed
class WidgetbookTheme with _$WidgetbookTheme {
  factory WidgetbookTheme({
    required String name,
    required IconData icon,
    // TODO This should be a generic type
    required ThemeData data,
  }) = _WidgetbookTheme;
}
