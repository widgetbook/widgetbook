import 'package:device_frame/device_frame.dart';
import 'package:flutter/widgets.dart';

import '../../addons/device_frame_addon/none_device.dart';
import '../../fields/fields.dart';
import 'base/mode.dart';
import 'base/modes_addon.dart';

class DeviceFrameMode extends Mode<DeviceInfo> {
  DeviceFrameMode({
    required DeviceInfo device,
    required this.orientation,
    required this.hasFrame,
  }) : super(device);

  final Orientation orientation;
  final bool hasFrame;

  @override
  Widget build(BuildContext context, Widget child) {
    if (value is NoneDevice) {
      return child;
    }

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: DeviceFrame(
          orientation: orientation,
          device: value,
          isFrameVisible: hasFrame,
          screen: hasFrame
              ? child
              : SafeArea(
                  child: child,
                ),
        ),
      ),
    );
  }
}

class DeviceFrameAddon extends ModesAddon<DeviceFrameMode> {
  DeviceFrameAddon(List<DeviceInfo> devices)
      : this.devices = [NoneDevice.instance, ...devices],
        super(
          name: 'Device Frame',
          modes: [
            // TODO: this is redundant
            DeviceFrameMode(
              device: devices.first,
              orientation: Orientation.portrait,
              hasFrame: true,
            ),
          ],
        );

  final List<DeviceInfo> devices;

  @override
  List<Field> get fields {
    return [
      ListField<DeviceInfo>(
        name: 'name',
        values: devices,
        initialValue: devices.first,
        labelBuilder: (device) => device.name,
      ),
      ListField<Orientation>(
        name: 'orientation',
        values: Orientation.values,
        initialValue: Orientation.portrait,
        labelBuilder: (orientation) =>
            orientation.name.substring(0, 1).toUpperCase() +
            orientation.name.substring(1),
      ),
      ListField<bool>(
        name: 'frame',
        values: [false, true],
        initialValue: true,
        labelBuilder: (hasFrame) => hasFrame ? 'Device Frame' : 'None',
      ),
    ];
  }

  @override
  DeviceFrameMode valueFromQueryGroup(Map<String, String> group) {
    return DeviceFrameMode(
      device: valueOf<DeviceInfo>('name', group)!,
      orientation: valueOf<Orientation>('orientation', group)!,
      hasFrame: valueOf<bool>('frame', group)!,
    );
  }
}
