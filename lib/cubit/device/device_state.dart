part of 'device_cubit.dart';

@immutable
class DeviceState {
  final List<Device> availableDevices;
  final Device currentDevice;

  DeviceState({
    required this.availableDevices,
    required this.currentDevice,
  });
}
