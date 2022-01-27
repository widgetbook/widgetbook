import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:widgetbook/src/rendering/render_mode.dart';
import 'package:widgetbook/src/rendering/rendering_state.dart';
import 'package:widgetbook/widgetbook.dart';

final renderingProvider = StateNotifierProvider<Rendering, RenderingState>(
  (ref) {
    return Rendering();
  },
);

class Rendering extends StateNotifier<RenderingState> {
  Rendering()
      : super(
          RenderingState(
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
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  width: device.resolution.logicalSize.width,
                  height: device.resolution.logicalSize.height,
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
              ThemeData theme,
              Widget child,
            ) {
              return Theme(
                data: theme,
                child: child,
              );
            },
            scaffoldBuilder: (
              BuildContext context,
              RenderMode renderMode,
              Widget child,
            ) {
              if (renderMode == RenderMode.widgetbook()) {
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
}
