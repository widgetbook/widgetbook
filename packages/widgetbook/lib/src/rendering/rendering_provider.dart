import 'package:widgetbook/src/rendering/rendering.dart';
import 'package:widgetbook/src/state_change_notifier.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class RenderingProvider<CustomTheme>
    extends StateChangeNotifier<RenderingState<CustomTheme>> {
  RenderingProvider({
    // TODO is this required?
    required List<WidgetbookFrame> frames,
    required ScaffoldBuilderFunction scaffoldBuilder,
    required AppBuilderFunction appBuilder,
    required UseCaseBuilderFunction useCaseBuilder,
  }) : super(
          state: RenderingState<CustomTheme>(
            frames: frames,
            scaffoldBuilder: scaffoldBuilder,
            appBuilder: appBuilder,
            useCaseBuilder: useCaseBuilder,
          ),
        );
}
