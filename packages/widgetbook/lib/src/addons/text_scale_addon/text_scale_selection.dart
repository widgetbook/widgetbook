import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_scale_selection.freezed.dart';

@freezed
class TextScaleSelection with _$TextScaleSelection {
  factory TextScaleSelection({
    required Set<double> activeTextScales,
    required List<double> textScales,
  }) = _TextScaleSelection;
}
