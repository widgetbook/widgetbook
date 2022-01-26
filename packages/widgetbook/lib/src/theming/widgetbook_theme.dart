import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'widgetbook_theme.freezed.dart';

@freezed
class WidgetbookTheme<T> with _$WidgetbookTheme<T> {
  factory WidgetbookTheme({
    required String name,
    required IconData icon,
    required T data,
  }) = _WidgetbookTheme;
}
