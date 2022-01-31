import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/localization/localization_provider.dart';
import 'package:widgetbook/src/providers/canvas_provider.dart';
import 'package:widgetbook/src/widgets/renderer.dart';
import 'package:widgetbook/src/workbench/comparison_setting.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

class ComparisonRenderer<CustomTheme> extends StatelessWidget {
  const ComparisonRenderer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final workbenchState =
        context.watch<WorkbenchProvider<CustomTheme>>().state;
    final localizationState = context.watch<LocalizationProvider>().state;

    switch (workbenchState.comparisonSetting) {
      case ComparisonSetting.none:
        // This cannot happen
        break;
      case ComparisonSetting.themes:
        return _buildRenderer(
          workbenchState.themes
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Renderer(
                    device: workbenchState.device!,
                    locale: workbenchState.locale!,
                    localizationsDelegates:
                        localizationState.localizationsDelegates,
                    theme: e.data,
                    deviceFrame: workbenchState.deviceFrame,
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
      case ComparisonSetting.devices:
        return _buildRenderer(
          workbenchState.devices
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Renderer(
                      device: e,
                      locale: workbenchState.locale!,
                      localizationsDelegates:
                          localizationState.localizationsDelegates,
                      theme: workbenchState.theme!.data,
                      deviceFrame: workbenchState.deviceFrame,
                      useCaseBuilder: (BuildContext context) =>
                          CanvasProvider.of(context)!
                              .state
                              .selectedStory!
                              .builder(context),
                    ),
                  ))
              .toList(),
        );

      case ComparisonSetting.localization:
        return _buildRenderer(
          workbenchState.locales
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Renderer(
                      device: workbenchState.device!,
                      locale: e,
                      localizationsDelegates:
                          localizationState.localizationsDelegates,
                      theme: workbenchState.theme!.data,
                      deviceFrame: workbenchState.deviceFrame,
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
