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
          final scaffoldBuilder = defaultScaffoldBuilder;
          final useCaseBuilder = defaultUseCaseBuilder;
          final textScaleBuilder = defaultTextScaleBuilder;
          const appBuilder = defaultAppBuilder;

          final provider = RenderingProvider(
            frames: frames,
            deviceFrameBuilder: deviceFrameBuilder,
            themeBuilder: themeBuilder,
            scaffoldBuilder: scaffoldBuilder,
            useCaseBuilder: useCaseBuilder,
            textScaleBuilder: textScaleBuilder,
            appBuilder: appBuilder,
          );

          expect(
            provider.state,
            equals(
              RenderingState(
                frames: frames,
                deviceFrameBuilder: deviceFrameBuilder,
                themeBuilder: themeBuilder,
                scaffoldBuilder: scaffoldBuilder,
                textScaleBuilder: textScaleBuilder,
                useCaseBuilder: useCaseBuilder,
                appBuilder: appBuilder,
              ),
            ),
          );
        },
      );
    },
  );
}
