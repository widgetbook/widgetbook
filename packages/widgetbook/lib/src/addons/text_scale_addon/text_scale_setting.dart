import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_scale_setting.freezed.dart';

@freezed
class TextScaleSetting with _$TextScaleSetting {
  @Assert('textScales.isNotEmpty', 'textScales cannot be empty')
  factory TextScaleSetting({
    required double activeTextScale,
    required List<double> textScales,
  }) = _TextScaleSetting;

  TextScaleSetting._();

  /// Sets the first text scale within `textScales` as the active text scale on
  /// startup
  factory TextScaleSetting.firstAsSelected({
    required List<double> textScales,
  }) {
    return TextScaleSetting(
      activeTextScale: textScales.first,
      textScales: textScales,
    );
  }
}
