import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/addons.dart';

class FrameSettingProvider extends ValueNotifier<FrameSetting> {
  FrameSettingProvider(super.data);

  void tapped(Frame frame) {
    final currentSelection = value.activeFrame;
    if (currentSelection != frame) {
      value = value.copyWith(activeFrame: frame);
    }
  }
}
