import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import 'frames/frames.dart';

class DeviceAddon extends WidgetbookAddOn<DeviceSetting> {
  DeviceAddon({
    required List<Device> devices,
    Device? initialDevice,
  })  : assert(
          devices.isNotEmpty,
          'Please specify at least one Device',
        ),
        assert(
          initialDevice == null || devices.contains(initialDevice),
          'initialDevice must be in devices',
        ),
        super(
          name: 'Device',
          setting: DeviceSetting(
            // [null] represents a "none" device
            devices: [null, ...devices],
            activeDevice: initialDevice,
          ),
        );

  @override
  Widget buildSetting(BuildContext context) {
    return Setting(
      name: 'Device',
      child: Row(
        children: [
          DropdownSetting<Device?>(
            options: setting.devices,
            optionValueBuilder: (device) => device?.name ?? 'None',
            initialSelection: setting.activeDevice,
            onSelected: (device) {
              onChanged(
                value.copyWith(
                  activeDevice: device,
                ),
              );
            },
          ),
          if (value.activeDevice != null) ...{
            IconButton(
              tooltip: 'Orientation',
              onPressed: () {
                onChanged(
                  value.copyWith(
                    orientation: value.orientation == Orientation.portrait
                        ? Orientation.landscape
                        : Orientation.portrait,
                  ),
                );
              },
              icon: Icon(
                value.orientation == Orientation.portrait
                    ? Icons.screen_lock_portrait
                    : Icons.screen_lock_landscape,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            IconButton(
              tooltip: 'Frame',
              onPressed: () {
                onChanged(
                  value.copyWith(
                    hasFrame: !value.hasFrame,
                  ),
                );
              },
              icon: Icon(
                Icons.smartphone,
                color: value.hasFrame
                    ? Theme.of(context).iconTheme.color
                    : Theme.of(context).disabledColor,
              ),
            ),
          }
        ],
      ),
    );
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child) {
    if (value.activeDevice == null) {
      return FramelessBuilder(
        setting: value,
      ).build(context, child);
    }

    if (!value.hasFrame) {
      return WidgetbookFrameBuilder(
        setting: value,
      ).build(context, child);
    }

    return DeviceFrameBuilder(
      setting: value,
    ).build(context, child);
  }
}

extension DeviceExtension on BuildContext {
  Device? get device => getAddonValue<DeviceSetting>()!.activeDevice;

  Orientation get orientation => getAddonValue<DeviceSetting>()!.orientation;
}
