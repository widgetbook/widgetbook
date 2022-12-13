import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_setting.dart';

class TextScaleSettingProvider extends ValueNotifier<TextScaleSetting> {
  TextScaleSettingProvider(super.data);

  void tapped(double textScales) {
    final currentSelection = value.activeTextScale;
    if (currentSelection != textScales) {
      value = value.copyWith(activeTextScale: textScales);
    }
  }
}
