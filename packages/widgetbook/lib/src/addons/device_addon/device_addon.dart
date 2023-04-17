import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import 'device_setting.dart';

class DeviceAddon extends WidgetbookAddOn<DeviceSetting> {
  DeviceAddon({
    required List<Device> devices,
  }) : super(
          name: 'Device',
          setting: DeviceSetting(
            // [null] represents a "none" device
            devices: [null, ...devices],
            activeDevice: null,
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SubSetting(
          name: '$Device',
          child: DropdownSetting<Device?>(
            options: value.devices,
            optionValueBuilder: (device) => device?.name ?? 'None',
            initialSelection: value.activeDevice,
            onSelected: (device) {
              onChanged(
                context,
                value.copyWith(
                  activeDevice: device,
                ),
              );
            },
          ),
        ),
        SubSetting(
          name: '$Orientation',
          child: DropdownSetting<Orientation>(
            options: const [
              Orientation.portrait,
              Orientation.landscape,
            ],
            optionValueBuilder: (orientation) => orientation.name,
            initialSelection: value.orientation,
            onSelected: (orientation) {
              onChanged(
                context,
                value.copyWith(
                  orientation: orientation,
                ),
              );
            },
          ),
        ),
        SubSetting(
          name: 'Frame',
          child: DropdownSetting<bool>(
            options: const [
              true,
              false,
            ],
            optionValueBuilder: (hasFrame) => hasFrame ? 'Device' : 'None',
            initialSelection: value.hasFrame,
            onSelected: (hasFrame) {
              onChanged(
                context,
                value.copyWith(
                  hasFrame: hasFrame,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

extension DeviceExtension on BuildContext {
  Device? get device => getAddonValue<DeviceSetting>()!.activeDevice;

  Orientation get orientation => getAddonValue<DeviceSetting>()!.orientation;

  Widget Function(BuildContext, Widget)? get frameBuilder {
    return getAddonValue<DeviceSetting>()!.frameBuilder.build;
  }
}
