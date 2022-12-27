import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/frame_addon/frame_provider.dart';
import 'package:widgetbook/src/addons/frame_addon/frame_selection_provider.dart';
import 'package:widgetbook/src/addons/models/models.dart';
import 'package:widgetbook/src/addons/widgets/widgets.dart';
import 'package:widgetbook/src/navigation/preview_provider.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook/widgetbook.dart';

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
      if (frame.addon.providerBuilder != null)
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

            final addons = context.read<AddOnProvider>().value;
            final queryParameters = <String, String>{};
            for (final addon in addons.where((addon) => addon is! FrameAddon)) {
              queryParameters.addAll(addon.getQueryParameter(context));
            }

            final usecase =
                context.read<PreviewProvider>().state.selectedUseCase;
            if (usecase != null) {
              queryParameters.putIfAbsent('path', () => usecase.path);
            }

            queryParameters
              ..putIfAbsent('frame', () => item.name)
              ..addAll(item.getDefaultQueryParameters);

            context.goNamed(
              '/',
              queryParams: queryParameters,
            );
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
  Frame get frame => watch<FrameProvider>().value;
}
