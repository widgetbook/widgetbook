import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/rendering/render_mode.dart';
import 'package:widgetbook/widgetbook.dart';

part 'rendering_state.freezed.dart';

@freezed
class RenderingState with _$RenderingState {
  factory RenderingState({
    required List<RenderMode> renderModes,
    required Widget Function(
      BuildContext context,
      Device device,
      RenderMode renderMode,
      Widget child,
    )
        deviceFrameBuilder,
    required Widget Function(
      BuildContext context,
      List<Locale> supportedLocales,
      List<LocalizationsDelegate<dynamic>> localizationsDelegates,
      Locale activeLocale,
      Widget child,
    )
        localizationBuilder,
    required Widget Function(
      BuildContext context,
      ThemeData theme,
      Widget child,
    )
        themeBuilder,
    required Widget Function(
      BuildContext context,
      RenderMode renderMode,
      Widget child,
    )
        scaffoldBuilder,
    required Widget Function(
      BuildContext context,
      Widget child,
    )
        useCaseBuilder,
  }) = _RenderingState;
}
