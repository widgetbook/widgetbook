import 'package:freezed_annotation/freezed_annotation.dart';

part 'widgetbook_text_scale_factor_data.freezed.dart';
part 'widgetbook_text_scale_factor_data.g.dart';

@freezed
class WidgetbookTextScaleFactorData with _$WidgetbookTextScaleFactorData {
  factory WidgetbookTextScaleFactorData({
    required double value,
  }) = _WidgetbookTextScaleFactorData;

  factory WidgetbookTextScaleFactorData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookTextScaleFactorDataFromJson(json);
}
