import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/localization/localization_provider.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/widgets/renderer.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

class DeviceRender<CustomTheme> extends StatelessWidget {
  const DeviceRender({
    Key? key,
    required this.story,
  }) : super(key: key);

  final WidgetbookUseCase story;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WorkbenchProvider<CustomTheme>>().state;
    final localizationState = context.watch<LocalizationProvider>().state;
    return Renderer(
      device: state.device!,
      locale: state.locale!,
      localizationsDelegates: localizationState.localizationsDelegates,
      theme: state.theme!.data,
      deviceFrame: state.deviceFrame,
      useCaseBuilder: story.builder,
    );
  }
}
