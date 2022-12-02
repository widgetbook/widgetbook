import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_setting.dart';

class TextScaleSettingProvider extends ValueNotifier<TextScaleSetting> {
  TextScaleSettingProvider(super.data);

  void tapped(double textScales) {
    // final currentSelection = List<double>.filled(
    //   value.textScales.length,
    //   0,
    //   growable: true,
    // ).toSet()
    //   ..addAll(value.activeTextScales.map((e) => e));
    final currentSelection = Set<double>.from(value.activeTextScales);

    if (currentSelection.contains(textScales)) {
      currentSelection.remove(textScales);
    } else {
      currentSelection.add(textScales);
    }

    value = value.copyWith(activeTextScales: currentSelection);
  }
}
