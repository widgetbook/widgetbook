import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';

part 'workbench_state.freezed.dart';

@freezed
class WorkbenchState with _$WorkbenchState {
  factory WorkbenchState({
    @Default(MultiRender.none) MultiRender multiRender,
    WidgetbookTheme? theme,
    Locale? locale,
  }) = _WorkbenchState;
}
