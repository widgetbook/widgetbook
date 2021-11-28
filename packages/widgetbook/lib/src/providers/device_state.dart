import 'package:collection/collection.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

class DeviceState {
  DeviceState({
    required this.availableDevices,
    required this.currentDevice,
    required this.orientation,
    required this.showKeyboard,
    required this.isFrameVisible,
  });

  final List<DeviceInfo> availableDevices;
  final DeviceInfo currentDevice;
  final Orientation orientation;
  final bool showKeyboard;
  final bool isFrameVisible;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is DeviceState &&
        listEquals(other.availableDevices, availableDevices) &&
        other.currentDevice == currentDevice &&
        other.showKeyboard == showKeyboard &&
        other.orientation == orientation &&
        other.isFrameVisible == isFrameVisible;
  }

  @override
  int get hashCode => availableDevices.hashCode ^ currentDevice.hashCode;
}
