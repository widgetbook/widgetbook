import 'package:flutter/material.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class FrameAddon extends WidgetbookAddOn<FrameSetting> {
  FrameAddon({
    required super.setting,
  }) : super(
          name: 'Frame',
        );

  @override
  Widget build(BuildContext context) {
    final frameBuilders = value.frames;
    final activeFrame = value.activeFrame;

    return ComplexSetting(
      name: 'Frame',
      sections: [
        if (activeFrame.addon.value.toQueryParameter().isNotEmpty)
          SettingSectionData(
            name: 'Properties',
            settings: [
              activeFrame.addon.build(context),
            ],
          ),
      ],
      setting: DropdownSetting<Frame>(
        options: frameBuilders,
        initialSelection: activeFrame,
        optionValueBuilder: (frame) => frame.name,
        onSelected: (frame) {
          onChanged(context, value.copyWith(activeFrame: frame));
        },
      ),
    );
  }

  @override
  Widget buildProvider(
    BuildContext context,
    Map<String, String> queryParameters,
    Widget child,
  ) {
    final initialData = settingFromQueryParameters(
      queryParameters: queryParameters,
      setting: setting,
    );
    return super.buildProvider(
      context,
      queryParameters,
      initialData.activeFrame.addon
          .buildProvider(context, queryParameters, child),
    );
  }

  @override
  FrameSetting settingFromQueryParameters({
    required Map<String, String> queryParameters,
    required FrameSetting setting,
  }) {
    final activeFrame = parseQueryParameters(
          name: 'frame',
          queryParameters: queryParameters,
          mappedData: {for (var e in setting.frames) e.name: e},
        ) ??
        setting.activeFrame;

    return setting.copyWith(activeFrame: activeFrame);
  }
}

extension FrameBuilderExtension on BuildContext {
  Frame? get frame => getAddonValue<FrameSetting>()?.activeFrame;

  /// Creates adjustable parameters for the WidgetbookUseCase
  Widget Function(BuildContext, Widget)? get frameBuilder => frame?.builder;
}
