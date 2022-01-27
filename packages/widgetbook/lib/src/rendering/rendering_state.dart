import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/rendering/render_mode.dart';
import 'package:widgetbook/widgetbook.dart';

part 'rendering_state.freezed.dart';

typedef DeviceFrameBuilderFunction = Widget Function(
  BuildContext context,
  Device device,
  RenderMode renderMode,
  Widget child,
);

typedef LocalizationBuilderFunction = Widget Function(
  BuildContext context,
  List<Locale> supportedLocales,
  List<LocalizationsDelegate<dynamic>> localizationsDelegates,
  Locale activeLocale,
  Widget child,
);

typedef ThemeBuilderFunction = Widget Function(
  BuildContext context,
  ThemeData theme,
  Widget child,
);

typedef ScaffoldBuilderFunction = Widget Function(
  BuildContext context,
  RenderMode renderMode,
  Widget child,
);

typedef UseCaseBuilderFunction = Widget Function(
  BuildContext context,
  Widget child,
);

@freezed
class RenderingState with _$RenderingState {
  factory RenderingState({
    required List<RenderMode> renderModes,
    required DeviceFrameBuilderFunction deviceFrameBuilder,
    required LocalizationBuilderFunction localizationBuilder,
    required ThemeBuilderFunction themeBuilder,
    required ScaffoldBuilderFunction scaffoldBuilder,
    required UseCaseBuilderFunction useCaseBuilder,
  }) = _RenderingState;
}
