import 'package:freezed_annotation/freezed_annotation.dart';

import '../../locales/models/model.dart';

part 'text_scale_factor_data.freezed.dart';
part 'text_scale_factor_data.g.dart';

@freezed
class TextScaleFactorData extends Model with _$TextScaleFactorData {
  factory TextScaleFactorData({
    required double value,
  }) = _TextScaleFactorData;

  factory TextScaleFactorData.fromJson(Map<String, dynamic> json) =>
      _$TextScaleFactorDataFromJson(json);
}
