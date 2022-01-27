import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/devices/devices.dart';
import 'package:widgetbook/src/localization/localization.dart';
import 'package:widgetbook/src/providers/canvas_provider.dart';
import 'package:widgetbook/src/theming/theming.dart';
import 'package:widgetbook/src/widgets/renderer.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

class MultiRenderer extends ConsumerWidget {
  const MultiRenderer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbenchState = ref.watch(workbenchProvider);
    final localizationState = ref.watch(localizationProvider);

    switch (workbenchState.multiRender) {
      case MultiRender.none:
        // This cannot happen
        break;
      case MultiRender.themes:
        final themingState = ref.read(themingProvider);
        return _buildRenderer(
          themingState.themes
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Renderer(
                    device: workbenchState.device!,
                    locale: workbenchState.locale!,
                    localizationsDelegates:
                        localizationState.localizationsDelegates,
                    theme: e.data,
                    renderMode: workbenchState.renderMode,
                    useCaseBuilder: (BuildContext context) =>
                        CanvasProvider.of(context)!
                            .state
                            .selectedStory!
                            .builder(context),
                  ),
                ),
              )
              .toList(),
        );
      case MultiRender.devices:
        final devicesState = ref.read(devicesProvider);
        return _buildRenderer(
          devicesState.devices
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Renderer(
                      device: e,
                      locale: workbenchState.locale!,
                      localizationsDelegates:
                          localizationState.localizationsDelegates,
                      theme: workbenchState.theme!.data,
                      renderMode: workbenchState.renderMode,
                      useCaseBuilder: (BuildContext context) =>
                          CanvasProvider.of(context)!
                              .state
                              .selectedStory!
                              .builder(context),
                    ),
                  ))
              .toList(),
        );

      case MultiRender.localization:
        return _buildRenderer(
          localizationState.supportedLocales
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Renderer(
                      device: workbenchState.device!,
                      locale: e,
                      localizationsDelegates:
                          localizationState.localizationsDelegates,
                      theme: workbenchState.theme!.data,
                      renderMode: workbenchState.renderMode,
                      useCaseBuilder: (BuildContext context) =>
                          CanvasProvider.of(context)!
                              .state
                              .selectedStory!
                              .builder(context),
                    ),
                  ))
              .toList(),
        );
    }

    return Container();
  }

  Widget _buildRenderer(List<Widget> widgets) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [...widgets],
    );
  }
}
