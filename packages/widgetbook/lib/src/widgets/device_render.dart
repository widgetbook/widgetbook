import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/localization/localization.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/widgets/renderer.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

class DeviceRender<CustomTheme> extends ConsumerWidget {
  const DeviceRender({
    Key? key,
    required this.story,
  }) : super(key: key);

  final WidgetbookUseCase story;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbenchState = ref.watch(getWorkbenchProvider<CustomTheme>());
    final localizationState = ref.watch(localizationProvider);
    return Renderer(
      device: workbenchState.device!,
      locale: workbenchState.locale!,
      localizationsDelegates: localizationState.localizationsDelegates,
      theme: workbenchState.theme!.data,
      renderMode: workbenchState.renderMode,
      useCaseBuilder: story.builder,
    );
  }
}
