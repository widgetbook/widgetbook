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
    required double? textScaleFactor,
    required WidgetbookFrame frame,
    @Default(Orientation.portrait) Orientation orientation,
    required List<WidgetbookTheme<CustomTheme>> themes,
    required List<Locale> locales,
    required List<Device> devices,
    required List<WidgetbookFrame> frames,
    required List<double> textScaleFactors,
  }) = _WorkbenchState;

  WorkbenchState._();

  bool get hasSelectedTheme => theme != null;
  bool get hasSelectedLocale => locale != null;
  bool get hasSelectedDevice => device != null;
  bool get hasSelectedTextScaleFactor => textScaleFactor != null;
}
