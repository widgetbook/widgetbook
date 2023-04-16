import 'package:flutter/material.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_setting.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class TextScaleAddon extends WidgetbookAddOn<TextScaleSetting> {
  TextScaleAddon({
    required super.setting,
  }) : super(
          name: 'text-scales',
        );

  @override
  Widget build(BuildContext context) {
    final textScales = value.textScales;
    final activeTextScale = value.activeTextScale;

    return Setting(
      name: 'Text scale',
      child: DropdownSetting<double>(
        options: textScales,
        initialSelection: activeTextScale,
        optionValueBuilder: (scale) => scale.toStringAsFixed(2),
        onSelected: (newTextScale) {
          onChanged(
            context,
            value.copyWith(activeTextScale: newTextScale),
          );
        },
      ),
    );
  }
}

extension TextScaleExtension on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  double? get textScale => getAddonValue<TextScaleSetting>()?.activeTextScale;
}
