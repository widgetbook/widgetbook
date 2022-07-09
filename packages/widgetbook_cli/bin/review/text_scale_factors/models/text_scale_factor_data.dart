import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_scale_factor_data.freezed.dart';
part 'text_scale_factor_data.g.dart';

@freezed
class TextScaleFactorData with _$TextScaleFactorData {
  factory TextScaleFactorData({
    required double value,
  }) = _TextScaleFactorData;

  factory TextScaleFactorData.fromJson(Map<String, dynamic> json) =>
      _$TextScaleFactorDataFromJson(json);
}
