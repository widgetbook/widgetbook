import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/localization/localization_provider.dart';
import 'package:widgetbook/src/localization/localization_state.dart';
import 'package:widgetbook/src/navigation/preview_provider.dart';
import 'package:widgetbook/src/workbench/comparison_setting.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';
import 'package:widgetbook/src/workbench/workbench_state.dart';

class ComparisonRenderer<CustomTheme> extends StatelessWidget {
  const ComparisonRenderer({Key? key}) : super(key: key);

  Widget _buildThemeComparison({
    required WorkbenchState<CustomTheme> workbenchState,
    required LocalizationState localizationState,
    required Widget Function(BuildContext) builder,
  }) {
    return _buildRenderer(
      workbenchState.themes
          .map(
            (e) => Renderer<CustomTheme>(
              device: workbenchState.device!,
              locale: workbenchState.locale!,
              localizationsDelegates: localizationState.localizationsDelegates,
              theme: e.data,
              frame: workbenchState.frame,
              textScaleFactor: workbenchState.textScaleFactor!,
              orientation: workbenchState.orientation,
              useCaseBuilder: builder,
            ),
          )
          .toList(),
    );
  }

  Widget _buildDeviceComparison({
    required WorkbenchState<CustomTheme> workbenchState,
    required LocalizationState localizationState,
    required Widget Function(BuildContext) builder,
  }) {
    return _buildRenderer(
      workbenchState.devices
          .map(
            (e) => Renderer(
              device: e,
              locale: workbenchState.locale!,
              localizationsDelegates: localizationState.localizationsDelegates,
              theme: workbenchState.theme!.data,
              frame: workbenchState.frame,
              textScaleFactor: workbenchState.textScaleFactor!,
              orientation: workbenchState.orientation,
              useCaseBuilder: builder,
            ),
          )
          .toList(),
    );
  }

  Widget _buildLocaleComparison({
    required WorkbenchState<CustomTheme> workbenchState,
    required LocalizationState localizationState,
    required Widget Function(BuildContext) builder,
  }) {
    return _buildRenderer(
      workbenchState.locales
          .map(
            (e) => Renderer(
              device: workbenchState.device!,
              locale: e,
              localizationsDelegates: localizationState.localizationsDelegates,
              theme: workbenchState.theme!.data,
              frame: workbenchState.frame,
              textScaleFactor: workbenchState.textScaleFactor!,
              orientation: workbenchState.orientation,
              useCaseBuilder: builder,
            ),
          )
          .toList(),
    );
  }

  Widget _buildtextScaleComparison({
    required WorkbenchState<CustomTheme> workbenchState,
    required LocalizationState localizationState,
    required Widget Function(BuildContext) builder,
  }) {
    return _buildRenderer(
      workbenchState.textScaleFactors
          .map(
            (e) => Renderer(
              device: workbenchState.device!,
              locale: workbenchState.locale!,
              localizationsDelegates: localizationState.localizationsDelegates,
              theme: workbenchState.theme!.data,
              frame: workbenchState.frame,
              textScaleFactor: e,
              orientation: workbenchState.orientation,
              useCaseBuilder: builder,
            ),
          )
          .toList(),
    );
  }

  Widget _buildSingleDevice({
    required WorkbenchState<CustomTheme> workbenchState,
    required LocalizationState localizationState,
    required Widget Function(BuildContext) builder,
  }) {
    return Renderer<CustomTheme>(
      device: workbenchState.device!,
      locale: workbenchState.locale!,
      localizationsDelegates: localizationState.localizationsDelegates,
      theme: workbenchState.theme!.data,
      frame: workbenchState.frame,
      textScaleFactor: workbenchState.textScaleFactor!,
      orientation: workbenchState.orientation,
      useCaseBuilder: builder,
    );
  }

  Widget _buildDevices({
    required WorkbenchState<CustomTheme> workbenchState,
    required LocalizationState localizationState,
    required Widget Function(BuildContext) builder,
  }) {
    switch (workbenchState.comparisonSetting) {
      case ComparisonSetting.none:
        return Padding(
          padding: const EdgeInsets.all(50),
          child: _buildSingleDevice(
              workbenchState: workbenchState,
              localizationState: localizationState,
              builder: builder),
        );
      case ComparisonSetting.themes:
        return _buildThemeComparison(
          workbenchState: workbenchState,
          localizationState: localizationState,
          builder: builder,
        );
      case ComparisonSetting.devices:
        return _buildDeviceComparison(
          workbenchState: workbenchState,
          localizationState: localizationState,
          builder: builder,
        );

      case ComparisonSetting.localization:
        return _buildLocaleComparison(
          workbenchState: workbenchState,
          localizationState: localizationState,
          builder: builder,
        );

      case ComparisonSetting.textScale:
        return _buildtextScaleComparison(
          workbenchState: workbenchState,
          localizationState: localizationState,
          builder: builder,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final workbenchState =
        context.watch<WorkbenchProvider<CustomTheme>>().state;
    final localizationState = context.watch<LocalizationProvider>().state;

    final builder =
        context.watch<PreviewProvider>().state.selectedUseCase!.builder;

    return _buildDevices(
      workbenchState: workbenchState,
      localizationState: localizationState,
      builder: builder,
    );
  }

  Widget _buildRenderer(List<Widget> widgets) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...widgets.map(
          (e) => Padding(
            padding: const EdgeInsets.all(
              50,
            ),
            child: e,
          ),
        ),
      ],
    );
  }
}
