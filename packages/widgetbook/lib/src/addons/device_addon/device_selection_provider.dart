import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/device_addon/frame_builders/frame_builder.dart';
import 'package:widgetbook/widgetbook.dart';

class DeviceSelectionProvider extends ValueNotifier<DeviceSelection> {
  DeviceSelectionProvider(DeviceSelection data) : super(data);

  void tappedFrameBuilder(FrameBuilder frameBuilder) {
    value = value.copyWith(activeFrameBuilder: frameBuilder);
  }

  void tappedDevice(Device device) {
    final currentSelection = Set<Device>.from(value.activeDevices);
    if (currentSelection.contains(device)) {
      currentSelection.remove(device);
    } else {
      currentSelection.add(device);
    }

    value = value.copyWith(activeDevices: currentSelection);
  }
}
