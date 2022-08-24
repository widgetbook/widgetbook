import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_selection.dart';

class TextScaleSelectionProvider extends ValueNotifier<TextScaleSelection> {
  TextScaleSelectionProvider(TextScaleSelection data) : super(data);

  void tapped(double textScales) {
    final currentSelection = Set<double>.from(value.activeTextScales);
    if (currentSelection.contains(textScales)) {
      currentSelection.remove(textScales);
    } else {
      currentSelection.add(textScales);
    }

    value = value.copyWith(activeTextScales: currentSelection);
  }
}
