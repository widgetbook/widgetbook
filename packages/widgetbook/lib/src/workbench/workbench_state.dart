import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/widgetbook.dart';

part 'workbench_state.freezed.dart';

@freezed
class WorkbenchState<CustomTheme> with _$WorkbenchState<CustomTheme> {
  factory WorkbenchState({
    @Default(MultiRender.none) MultiRender multiRender,
    WidgetbookTheme<CustomTheme>? theme,
    Locale? locale,
    Device? device,
    required RenderMode renderMode,
  }) = _WorkbenchState;
}
