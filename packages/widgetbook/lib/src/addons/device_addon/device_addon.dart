import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'device_setting.dart';

class DeviceAddon extends WidgetbookAddOn<DeviceSetting> {
  DeviceAddon({
    required List<DeviceInfo> devices,
    DeviceInfo? initialDevice,
  })  : assert(
          devices.isNotEmpty,
          'devices cannot be empty',
        ),
        assert(
          initialDevice == null || devices.contains(initialDevice),
          'initialDevice must be in devices',
        ),
        super(
          name: 'Device',
          initialSetting: DeviceSetting(
            // [null] represents a "none" device
            devices: [null, ...devices],
            activeDevice: initialDevice,
          ),
        );

  @override
  List<Field> get fields {
    return [
      ListField<DeviceInfo?>(
        group: slugName,
        name: 'name',
        values: setting.devices,
        initialValue: setting.activeDevice,
        labelBuilder: (device) => device?.name ?? 'None',
        onChanged: (_, device) {
          if (device == null) return;

          updateSetting(
            setting.copyWith(
              activeDevice: device,
            ),
          );
        },
      ),
      ListField<Orientation>(
        group: slugName,
        name: 'orientation',
        values: Orientation.values,
        initialValue: setting.orientation,
        labelBuilder: (orientation) =>
            orientation.name.substring(0, 1).toUpperCase() +
            orientation.name.substring(1),
        onChanged: (_, orientation) {
          if (orientation == null) return;

          updateSetting(
            setting.copyWith(
              orientation: orientation,
            ),
          );
        },
      ),
      ListField<bool>(
        group: slugName,
        name: 'frame',
        values: [false, true],
        initialValue: setting.hasFrame,
        labelBuilder: (hasFrame) => hasFrame ? 'Device Frame' : 'None',
        onChanged: (_, hasFrame) {
          if (hasFrame == null) return;

          updateSetting(
            setting.copyWith(
              hasFrame: hasFrame,
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child) {
    if (setting.activeDevice == null) {
      return child;
    }

    return DeviceFrame(
      orientation: setting.orientation,
      device: setting.activeDevice!,
      isFrameVisible: setting.hasFrame,
      screen: child,
    );
  }
}
