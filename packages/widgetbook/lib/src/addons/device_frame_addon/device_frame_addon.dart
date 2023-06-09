import 'package:collection/collection.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'device_frame_setting.dart';

/// A [WidgetbookAddon] for changing the active device/frame. It's based on
/// the [`device_frame`](https://pub.dev/packages/device_frame) package.
class DeviceFrameAddon extends WidgetbookAddon<DeviceFrameSetting> {
  DeviceFrameAddon({
    required List<DeviceInfo?> devices,
    DeviceInfo? initialDevice,
  })  : assert(
          devices.isNotEmpty,
          'devices cannot be empty',
        ),
        assert(
          initialDevice == null || devices.contains(initialDevice),
          'initialDevice must be in devices',
        ),
        this.devices = [null, ...devices], // [null] represents a "none" device
        super(
          name: 'Device',
          initialSetting: DeviceFrameSetting(
            device: initialDevice,
          ),
        );

  final List<DeviceInfo?> devices;

  @override
  List<Field> get fields {
    return [
      ListField<DeviceInfo?>(
        group: slugName,
        name: 'name',
        values: devices,
        initialValue: initialSetting.device,
        labelBuilder: (device) => device?.name ?? 'None',
      ),
      ListField<Orientation>(
        group: slugName,
        name: 'orientation',
        values: Orientation.values,
        initialValue: initialSetting.orientation,
        labelBuilder: (orientation) =>
            orientation.name.substring(0, 1).toUpperCase() +
            orientation.name.substring(1),
      ),
      ListField<bool>(
        group: slugName,
        name: 'frame',
        values: [false, true],
        initialValue: initialSetting.hasFrame,
        labelBuilder: (hasFrame) => hasFrame ? 'Device Frame' : 'None',
      ),
    ];
  }

  @override
  DeviceFrameSetting settingFromQueryGroup(Map<String, String> group) {
    return DeviceFrameSetting(
      device: devices.firstWhereOrNull(
        (device) => device?.name == group['name'],
      ),
      orientation: Orientation.values.byName(
        group['orientation']?.toLowerCase() ?? Orientation.portrait.name,
      ),
      hasFrame: group['frame'] == 'true',
    );
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    DeviceFrameSetting setting,
  ) {
    if (setting.device == null) {
      return child;
    }

    return DeviceFrame(
      orientation: setting.orientation,
      device: setting.device!,
      isFrameVisible: setting.hasFrame,
      screen: child,
    );
  }
}
