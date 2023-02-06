import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/frame_addon/frame_provider.dart';
import 'package:widgetbook/src/addons/frame_addon/frame_selection_provider.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class FrameAddon extends WidgetbookAddOn {
  FrameAddon({
    required FrameSetting setting,
  }) : super(
          name: 'Frame',
          wrapperBuilder: (context, routerData, child) => _wrapperBuilder(
            context,
            child,
            routerData,
            setting,
          ),
          builder: _builder,
          providerBuilder: _providerBuilder,
          getQueryParameter: _getQueryParameter,
        );
}

Map<String, String> _getQueryParameter(BuildContext context) {
  final selectedItem = context.read<FrameSettingProvider>().value.activeFrame;

  return {
    'frame': selectedItem.name,
  }..addAll(
      selectedItem.addon.getQueryParameter(context),
    );
}

SingleChildWidget _providerBuilder(
  BuildContext context,
) {
  final selection = context.watch<FrameSettingProvider>().value;
  final frame = selection.activeFrame;

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        key: ValueKey(frame),
        create: (context) => FrameProvider(frame),
      ),
      frame.addon.providerBuilder(context)
    ],
  );
}

Widget _wrapperBuilder(
  BuildContext context,
  Widget child,
  Map<String, dynamic> routerData,
  FrameSetting data,
) {
  final Frame? selectedFrame = parseRouterData(
    name: 'frame',
    routerData: routerData,
    mappedData: {for (var e in data.frames) e.name: e},
  );

  final initialData =
      selectedFrame != null ? data.copyWith(activeFrame: selectedFrame) : data;
  final activeFrame = initialData.activeFrame;
  return ChangeNotifierProvider(
    key: ValueKey(initialData),
    create: (_) => FrameSettingProvider(initialData),
    child: activeFrame.addon.wrapperBuilder(
      context,
      routerData,
      child,
    ),
  );
}

Widget _builder(BuildContext context) {
  final setting = context.watch<FrameSettingProvider>().value;
  final frameBuilders = setting.frames;
  final activeFrame = setting.activeFrame;

  return ComplexSetting(
    name: 'Frame',
    sections: [
      if (activeFrame.getDefaultQueryParameters.isNotEmpty)
        SettingSectionData(
          name: 'Properties',
          settings: [
            activeFrame.addon.builder(context),
          ],
        ),
    ],
    setting: DropdownSetting<Frame>(
      options: frameBuilders,
      initialSelection: activeFrame,
      optionValueBuilder: (frame) => frame.name,
      onSelected: (frame) {
        context.read<FrameSettingProvider>().tapped(frame);
        context.read<AddOnProvider>().update();
        context.goTo(
          queryParams: {
            'frame': frame.name,
            ...frame.getDefaultQueryParameters,
          },
        );
      },
    ),
  );
}

extension FrameBuilderExtension on BuildContext {
  Frame? get frame => watch<FrameProvider?>()?.value;

  /// Creates adjustable parameters for the WidgetbookUseCase
  Widget Function(BuildContext, Widget)? get frameBuilder => frame?.builder;
}
