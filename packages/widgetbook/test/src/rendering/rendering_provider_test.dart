import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/rendering/builders/text_scale_builder.dart';
import 'package:widgetbook/src/rendering/rendering.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

void main() {
  group(
    '$RenderingProvider',
    () {
      test(
        'sets state',
        () {
          final frames = [
            WidgetbookFrame.defaultFrame(),
            WidgetbookFrame.noFrame(),
          ];

          final deviceFrameBuilder = defaultDeviceFrameBuilder;
          final localizationBuilder = defaultLocalizationBuilder;
          final themeBuilder = defaultThemeBuilder<ThemeData>();
          final scaffoldBuilder = defaultScaffoldBuilder;
          final useCaseBuilder = defaultUseCaseBuilder;
          final textScaleBuilder = defaultTextScaleBuilder;

          final provider = RenderingProvider(
            frames: frames,
            deviceFrameBuilder: deviceFrameBuilder,
            localizationBuilder: localizationBuilder,
            themeBuilder: themeBuilder,
            scaffoldBuilder: scaffoldBuilder,
            useCaseBuilder: useCaseBuilder,
            textScaleBuilder: textScaleBuilder,
          );

          expect(
            provider.state,
            equals(
              RenderingState(
                frames: frames,
                deviceFrameBuilder: deviceFrameBuilder,
                localizationBuilder: localizationBuilder,
                themeBuilder: themeBuilder,
                scaffoldBuilder: scaffoldBuilder,
                textScaleBuilder: textScaleBuilder,
                useCaseBuilder: useCaseBuilder,
              ),
            ),
          );
        },
      );
    },
  );
}
