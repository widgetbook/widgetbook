import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:widgetbook/src/rendering/rendering_state.dart';
import 'package:widgetbook/widgetbook.dart';

late Object _renderingProvider;

StateNotifierProvider<Rendering<CustomTheme>, RenderingState<CustomTheme>>
    getRenderingProvider<CustomTheme>() {
  return _renderingProvider as StateNotifierProvider<Rendering<CustomTheme>,
      RenderingState<CustomTheme>>;
}

void initializeRenderingProvider<CustomTheme>() {
  _renderingProvider = StateNotifierProvider<Rendering<CustomTheme>,
      RenderingState<CustomTheme>>(
    (ref) {
      return Rendering<CustomTheme>();
    },
  );
}

// TODO remove when this is working
// final renderingProvider = StateNotifierProvider<Rendering, RenderingState>(
//   (ref) {
//     return Rendering();
//   },
// );

class Rendering<CustomTheme>
    extends StateNotifier<RenderingState<CustomTheme>> {
  Rendering()
      : super(
          RenderingState<CustomTheme>(
            renderModes: [
              RenderMode.widgetbook(),
              RenderMode.none(),
            ],
            deviceFrameBuilder: (
              BuildContext context,
              Device device,
              RenderMode renderMode,
              Widget child,
            ) {
              if (renderMode == RenderMode.widgetbook()) {
                return WidgetbookDeviceFrame(
                  device: device,
                  child: child,
                );
              }

              return child;
            },
            localizationBuilder: (
              BuildContext context,
              List<Locale> supportedLocales,
              List<LocalizationsDelegate<dynamic>> localizationsDelegates,
              Locale activeLocale,
              Widget child,
            ) {
              return Localizations(
                locale: activeLocale,
                delegates: localizationsDelegates,
                child: child,
              );
            },
            themeBuilder: (
              BuildContext context,
              CustomTheme theme,
              Widget child,
            ) {
              if (theme is ThemeData) {
                return Theme(
                  data: theme,
                  child: child,
                );
              }
              if (theme is CupertinoThemeData) {
                return CupertinoTheme(
                  data: theme,
                  child: child,
                );
              }

              throw Exception(
                'You are using Widgetbook with custom theme data. '
                'Please provide an implementation for themeBuilder.',
              );
            },
            scaffoldBuilder: (
              BuildContext context,
              RenderMode renderMode,
              Widget child,
            ) {
              if (renderMode == RenderMode.widgetbook() ||
                  renderMode == RenderMode.devicePreview()) {
                return Scaffold(
                  body: child,
                );
              }

              return child;
            },
            useCaseBuilder: (BuildContext context, Widget child) {
              return child;
            },
          ),
        );

  void renderModesChanged(List<RenderMode>? renderModes) {
    if (renderModes != null) {
      state = state.copyWith(renderModes: renderModes);
    }
  }

  void deviceFrameBuilderChanged(
    DeviceFrameBuilderFunction? deviceFrameBuilder,
  ) {
    if (deviceFrameBuilder != null) {
      state = state.copyWith(deviceFrameBuilder: deviceFrameBuilder);
    }
  }

  void localizationBuilderChanged(
    LocalizationBuilderFunction? localizationBuilder,
  ) {
    if (localizationBuilder != null) {
      state = state.copyWith(localizationBuilder: localizationBuilder);
    }
  }

  void themeBuilderChanged(
    ThemeBuilderFunction<CustomTheme>? themeBuilder,
  ) {
    if (themeBuilder != null) {
      state = state.copyWith(themeBuilder: themeBuilder);
    }
  }

  void scaffoldBuilderChanged(
    ScaffoldBuilderFunction? scaffoldBuilder,
  ) {
    if (scaffoldBuilder != null) {
      state = state.copyWith(scaffoldBuilder: scaffoldBuilder);
    }
  }

  void useCaseBuilderChanged(
    UseCaseBuilderFunction? useCaseBuilder,
  ) {
    if (useCaseBuilder != null) {
      state = state.copyWith(useCaseBuilder: useCaseBuilder);
    }
  }
}
