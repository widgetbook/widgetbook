import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_scale_setting.freezed.dart';

@freezed
class TextScaleSetting with _$TextScaleSetting {
  factory TextScaleSetting({
    required Set<double> activeTextScales,
    required List<double> textScales,
  }) = _TextScaleSetting;

  TextScaleSetting._();

  /// Sets the first text scale within `textScales` as the active text scale on
  /// startup
  factory TextScaleSetting.firstAsSelected({
    required List<double> textScales,
  }) {
    return TextScaleSetting(
      activeTextScales: textScales.take(1).toSet(),
      textScales: textScales,
    );
  }

  /// Sets all `textScales` as the active text scales on
  /// startup
  factory TextScaleSetting.allAsSelected({
    required List<double> textScales,
  }) {
    return TextScaleSetting(
      activeTextScales: textScales.toSet(),
      textScales: textScales,
    );
  }
}
