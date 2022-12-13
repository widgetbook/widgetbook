import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/addons.dart';
import 'package:widgetbook/src/addons/frame_addon/frame_provider.dart';
import 'package:widgetbook/src/addons/frame_addon/frame_selection_provider.dart';
import 'package:widgetbook/src/addons/models/models.dart';
import 'package:widgetbook/src/addons/utilities/utilities.dart';
import 'package:widgetbook/src/addons/widgets/widgets.dart';
import 'package:widgetbook/src/navigation/router.dart';

class FrameAddon extends WidgetbookAddOn {
  FrameAddon({
    required FrameSetting setting,
  }) : super(
          icon: const Icon(Icons.phone),
          name: 'Frame',
          wrapperBuilder: (context, routerData, child) => _wrapperBuilder(
            context,
            child,
            routerData,
            setting,
          ),
          panelSize: PanelSize.large,
          builder: _builder,
          providerBuilder: _providerBuilder,
          getQueryParameter: _getQueryParameter,
        );
}

Map<String, dynamic> _getQueryParameter(BuildContext context) {
  final selectedItem = context.read<FrameSettingProvider>().value.activeFrame;

  return <String, dynamic>{
    'frame': selectedItem.name,
  }..addAll(
      selectedItem.addon.getQueryParameter(context) as Map<String, dynamic>,
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
      if (frame.addon.providerBuilder != null)
        frame.addon.providerBuilder!(context)
    ],
  );
}

Widget _wrapperBuilder(
  BuildContext context,
  Widget child,
  Map<String, dynamic> routerData,
  FrameSetting data,
) {
  final activeFrameData = routerData['Frame'] as String?;

  Frame? selectedFrame;

  final activeFrameName = activeFrameData != null
      ? context.jsonToString(
          data: activeFrameData,
          addonItem: 'frame',
        )
      : null;

  if (activeFrameName != null) {
    final mapFrames = {for (var e in data.frames) e.name: e};

    selectedFrame = mapFrames[activeFrameName];
  }

  final initialData =
      selectedFrame != null ? data.copyWith(activeFrame: selectedFrame) : data;
  final activeFrame = initialData.activeFrame;
  return ChangeNotifierProvider(
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

  return Row(
    children: [
      Expanded(
        child: AddonOptionList<Frame>(
          name: 'Frames',
          options: frameBuilders,
          selectedOption: activeFrame,
          builder: (item) => Text(item.name),
          onTap: (item) {
            context.read<FrameSettingProvider>().tapped(item);
            context.read<AddOnProvider>().update();
            navigate(context);
          },
        ),
      ),
      Expanded(
        child: activeFrame.addon.builder(context),
      ),
    ],
  );
}

extension FrameBuilderExtension on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  Widget Function(BuildContext, Widget) get frameBuilder =>
      watch<FrameProvider>().value.builder;
}
