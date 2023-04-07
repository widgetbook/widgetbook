import 'package:flutter/material.dart';
import 'package:widgetbook/src/routing/router.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

export './device_setting.dart';

class DeviceAddon extends WidgetbookAddOn<DeviceSetting> {
  DeviceAddon({
    required super.setting,
  }) : super(
          name: 'Device',
        );

  @override
  DeviceSetting settingFromQueryParameters({
    required Map<String, String> queryParameters,
    required DeviceSetting setting,
  }) {
    final activeDevice = parseQueryParameters(
          name: 'device',
          queryParameters: queryParameters,
          mappedData: {for (var e in setting.devices) e.name: e},
        ) ??
        setting.activeDevice;
    final activeOrientation = parseQueryParameters(
          name: 'orientation',
          queryParameters: queryParameters,
          mappedData: {
            Orientation.portrait.name: Orientation.portrait,
            Orientation.landscape.name: Orientation.landscape,
          },
        ) ??
        setting.orientation;

    return setting.copyWith(
      activeDevice: activeDevice,
      orientation: activeOrientation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SubSetting(
          name: '$Device',
          child: DropdownSetting<Device>(
            options: value.devices,
            optionValueBuilder: (device) => device.name,
            initialSelection: value.activeDevice,
            onSelected: (newActiveDevice) {
              onChanged(context, value.copyWith(activeDevice: newActiveDevice));
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
              onChanged(context, value.copyWith(orientation: orientation));
            },
          ),
        ),
      ],
    );
  }
}

extension DeviceExtension on BuildContext {
  Device get device => getAddonValue<DeviceSetting>()!.activeDevice;
}

extension OrientationExtension on BuildContext {
  Orientation get orientation => getAddonValue<DeviceSetting>()!.orientation;
}
