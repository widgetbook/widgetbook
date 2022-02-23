import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/rendering/builders/text_scale_builder.dart';

import 'package:widgetbook/src/rendering/rendering.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

part 'rendering_state.freezed.dart';

@freezed
class RenderingState<CustomTheme> with _$RenderingState<CustomTheme> {
  factory RenderingState({
    required List<WidgetbookFrame> frames,
    required DeviceFrameBuilderFunction deviceFrameBuilder,
    required LocalizationBuilderFunction localizationBuilder,
    required ThemeBuilderFunction<CustomTheme> themeBuilder,
    required ScaffoldBuilderFunction scaffoldBuilder,
    required TextScaleBuilder textScaleBuilder,
    required UseCaseBuilderFunction useCaseBuilder,
  }) = _RenderingState;
}
