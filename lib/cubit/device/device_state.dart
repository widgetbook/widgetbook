part of 'device_cubit.dart';

class DeviceState {
  final List<Device> availableDevices;
  final Device currentDevice;

  DeviceState({
    required this.availableDevices,
    required this.currentDevice,
  });
}
