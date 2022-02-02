import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:widgetbook/src/rendering/rendering.dart';

part 'rendering_state.freezed.dart';

@freezed
class RenderingState<CustomTheme> with _$RenderingState<CustomTheme> {
  factory RenderingState({
    required List<WidgetbookFrame> deviceFrames,
    required DeviceFrameBuilderFunction deviceFrameBuilder,
    required LocalizationBuilderFunction localizationBuilder,
    required ThemeBuilderFunction<CustomTheme> themeBuilder,
    required ScaffoldBuilderFunction scaffoldBuilder,
    required UseCaseBuilderFunction useCaseBuilder,
  }) = _RenderingState;
}
