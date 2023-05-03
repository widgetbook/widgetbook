import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../fields/fields.dart';
import 'frames/frames.dart';

class DeviceAddon extends WidgetbookAddOn<DeviceSetting> {
  DeviceAddon({
    required List<Device> devices,
    Device? initialDevice,
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
      ListField<Device?>(
        name: 'name',
        values: setting.devices,
        value: setting.activeDevice,
        labelBuilder: (device) => device?.name ?? 'None',
        onChanged: (device) {
          updateSetting(
            setting.copyWith(
              activeDevice: device,
            ),
          );
        },
      ),
      ListField<Orientation>(
        name: 'orientation',
        values: Orientation.values,
        value: setting.orientation,
        labelBuilder: (orientation) =>
            orientation.name.substring(0, 1).toUpperCase() +
            orientation.name.substring(1),
        onChanged: (orientation) {
          updateSetting(
            setting.copyWith(
              orientation: orientation,
            ),
          );
        },
      ),
      ListField<bool>(
        name: 'frame',
        values: [false, true],
        value: setting.hasFrame,
        labelBuilder: (hasFrame) => hasFrame ? 'Device Frame' : 'None',
        onChanged: (hasFrame) {
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

    if (!setting.hasFrame) {
      return WidgetbookFrameBuilder(
        setting: setting,
      ).build(context, child);
    }

    return DeviceFrameBuilder(
      setting: setting,
    ).build(context, child);
  }
}
