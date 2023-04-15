import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

part 'text_scale_setting.freezed.dart';

@freezed
class TextScaleSetting extends WidgetbookAddOnModel<TextScaleSetting>
    with _$TextScaleSetting {
  @Assert('textScales.isNotEmpty', 'textScales cannot be empty')
  factory TextScaleSetting({
    required double activeTextScale,
    required List<double> textScales,
  }) = _TextScaleSetting;

  /// Sets the first text scale within `textScales` as the active text scale on
  /// startup
  factory TextScaleSetting.firstAsSelected({
    required List<double> textScales,
  }) {
    assert(
      textScales.isNotEmpty,
      'Please specify at least one TextScaleFactor',
    );
    return TextScaleSetting(
      activeTextScale: textScales.first,
      textScales: textScales,
    );
  }

  TextScaleSetting._();

  @override
  Map<String, String> toQueryParameter() {
    return {
      'text-scale': activeTextScale.toStringAsFixed(2),
    };
  }

  @override
  TextScaleSetting? fromQueryParameter(Map<String, String> queryParameters) {
    return this.copyWith(
      activeTextScale: textScales.firstWhere(
        (scale) => scale.toStringAsFixed(2) == queryParameters['text-scale'],
        orElse: () => activeTextScale,
      ),
    );
  }
}
