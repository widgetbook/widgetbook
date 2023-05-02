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
          'devices cannot be empty',
        ),
        assert(
          initialDevice == null || devices.contains(initialDevice),
          'initialDevice must be in devices',
        ),
        super(
          initialSetting: DeviceSetting(
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
              updateSetting(
                setting.copyWith(
                  activeDevice: device,
                ),
              );
            },
          ),
          if (setting.activeDevice != null) ...{
            IconButton(
              tooltip: 'Orientation',
              onPressed: () {
                updateSetting(
                  setting.copyWith(
                    orientation: setting.orientation == Orientation.portrait
                        ? Orientation.landscape
                        : Orientation.portrait,
                  ),
                );
              },
              icon: Icon(
                setting.orientation == Orientation.portrait
                    ? Icons.screen_lock_portrait
                    : Icons.screen_lock_landscape,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            IconButton(
              tooltip: 'Frame',
              onPressed: () {
                updateSetting(
                  setting.copyWith(
                    hasFrame: !setting.hasFrame,
                  ),
                );
              },
              icon: Icon(
                Icons.smartphone,
                color: setting.hasFrame
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
