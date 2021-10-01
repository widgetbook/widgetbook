import 'package:collection/collection.dart';

import 'package:widgetbook/src/models/device.dart';

class DeviceState {
  final List<Device> availableDevices;
  final Device currentDevice;

  DeviceState({
    required this.availableDevices,
    required this.currentDevice,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is DeviceState &&
        listEquals(other.availableDevices, availableDevices) &&
        other.currentDevice == currentDevice;
  }

  @override
  int get hashCode => availableDevices.hashCode ^ currentDevice.hashCode;
}
