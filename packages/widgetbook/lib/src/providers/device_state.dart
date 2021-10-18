import 'package:collection/collection.dart';

import 'package:widgetbook_models/widgetbook_models.dart';

class DeviceState {
  DeviceState({
    required this.availableDevices,
    required this.currentDevice,
  });

  final List<Device> availableDevices;
  final Device currentDevice;

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
