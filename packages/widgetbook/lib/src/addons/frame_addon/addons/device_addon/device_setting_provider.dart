import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class DeviceSettingProvider extends ValueNotifier<DeviceSetting> {
  DeviceSettingProvider(super.data);

  void deviceTapped(Device frame) {
    final currentSelection = value.activeDevice;
    if (currentSelection != frame) {
      value = value.copyWith(activeDevice: frame);
    }
  }

  void orientationTapped(Orientation orientation) {
    value = value.copyWith(orientation: orientation);
  }
}
