import '../../addons/addons.dart';
import 'mode.dart';

class DeviceFrameMode extends DeviceFrameAddon with Mode<DeviceFrameSetting> {
  DeviceFrameMode({
    required super.devices,
    super.initialDevice,
  });
}
