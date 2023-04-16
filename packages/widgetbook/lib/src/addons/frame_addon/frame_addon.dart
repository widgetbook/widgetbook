import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class FrameAddon extends WidgetbookAddOn<FrameSetting> {
  FrameAddon({
    required super.setting,
  }) : super(
          name: 'Frame',
        );

  @override
  void addListener(ValueChanged<FrameSetting> listener) {
    super.addListener(listener);

    value.frames.forEach((frame) {
      frame.addon.addListener(
        listener as ValueChanged<WidgetbookAddOnModel>,
      );
    });
  }

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
    final newSetting = setting.fromQueryParameter(queryParameters) ?? setting;

    return super.buildProvider(
      context,
      queryParameters,
      newSetting.activeFrame.addon.buildProvider(
        context,
        queryParameters,
        child,
      ),
    );
  }
}

extension FrameBuilderExtension on BuildContext {
  Frame? get frame => getAddonValue<FrameSetting>()?.activeFrame;

  /// Creates adjustable parameters for the WidgetbookUseCase
  Widget Function(BuildContext, Widget)? get frameBuilder => frame?.builder;
}
