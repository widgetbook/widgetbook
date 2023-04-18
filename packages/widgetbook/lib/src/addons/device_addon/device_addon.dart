import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/device_addon/frames/frames.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class DeviceAddon extends WidgetbookAddOn<DeviceSetting> {
  DeviceAddon({
    required List<Device> devices,
    Device? initialDevice,
  })  : assert(
          devices.isNotEmpty,
          'Please specify at least one Device',
        ),
        assert(
          devices.contains(initialDevice),
          '[initialDevice] must be in [devices]',
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
  Widget build(BuildContext context) {
    return Setting(
      name: 'Device',
      child: Row(
        children: [
          DropdownSetting<Device?>(
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
          if (value.activeDevice != null) ...{
            IconButton(
              tooltip: 'Orientation',
              onPressed: () {
                onChanged(
                  context,
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
                  context,
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
}

extension DeviceExtension on BuildContext {
  Device? get device => getAddonValue<DeviceSetting>()!.activeDevice;

  Orientation get orientation => getAddonValue<DeviceSetting>()!.orientation;

  FrameBuilder? get frameBuilder {
    return getAddonValue<DeviceSetting>()?.frameBuilder;
  }
}
