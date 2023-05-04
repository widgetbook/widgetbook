import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_scale_setting.freezed.dart';

@freezed
class TextScaleSetting with _$TextScaleSetting {
  factory TextScaleSetting({
    required double activeTextScale,
    required List<double> textScales,
  }) = _TextScaleSetting;

  TextScaleSetting._();
}
