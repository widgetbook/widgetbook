import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/workbench/comparison_setting.dart';
import 'package:widgetbook/widgetbook.dart';

part 'workbench_state.freezed.dart';

@freezed
class WorkbenchState<CustomTheme> with _$WorkbenchState<CustomTheme> {
  factory WorkbenchState({
    @Default(ComparisonSetting.none) ComparisonSetting comparisonSetting,
    WidgetbookTheme<CustomTheme>? theme,
    Locale? locale,
    Device? device,
    required DeviceFrame deviceFrame,
  }) = _WorkbenchState;
}
