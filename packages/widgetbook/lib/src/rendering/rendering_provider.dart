import 'package:widgetbook/src/rendering/rendering.dart';
import 'package:widgetbook/src/state_change_notifier.dart';

class RenderingProvider<CustomTheme>
    extends StateChangeNotifier<RenderingState<CustomTheme>> {
  RenderingProvider({
    required List<WidgetbookFrame> frames,
    required DeviceFrameBuilderFunction deviceFrameBuilder,
    required LocalizationBuilderFunction localizationBuilder,
    required ThemeBuilderFunction<CustomTheme> themeBuilder,
    required ScaffoldBuilderFunction scaffoldBuilder,
    required UseCaseBuilderFunction useCaseBuilder,
  }) : super(
          state: RenderingState<CustomTheme>(
            frames: frames,
            deviceFrameBuilder: deviceFrameBuilder,
            localizationBuilder: localizationBuilder,
            themeBuilder: themeBuilder,
            scaffoldBuilder: scaffoldBuilder,
            useCaseBuilder: useCaseBuilder,
          ),
        );
}
