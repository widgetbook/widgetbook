import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../fields/fields.dart';

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
      DropdownField<DeviceInfo?>(
        group: slugName,
        name: 'name',
        values: setting.devices,
        initialValue: setting.activeDevice,
        labelBuilder: (device) => device?.name ?? 'None',
        codec: FieldCodec(
          toParam: (device) => device?.name ?? 'None',
          toValue: (param) => setting.devices.firstWhere(
            (device) => device?.name == param,
            orElse: () => null,
          ),
        ),
        onChanged: (device) {
          if (device == null) return;

          updateSetting(
            setting.copyWith(
              activeDevice: device,
            ),
          );
        },
      ),
      DropdownField<Orientation>(
        group: slugName,
        name: 'orientation',
        values: Orientation.values,
        initialValue: setting.orientation,
        labelBuilder: (orientation) =>
            orientation.name.substring(0, 1).toUpperCase() +
            orientation.name.substring(1),
        codec: FieldCodec(
          toParam: (orientation) => orientation.name,
          toValue: (param) => Orientation.values.byName(
            param ?? Orientation.portrait.name,
          ),
        ),
        onChanged: (orientation) {
          if (orientation == null) return;

          updateSetting(
            setting.copyWith(
              orientation: orientation,
            ),
          );
        },
      ),
      DropdownField<bool>(
        group: slugName,
        name: 'frame',
        values: [false, true],
        initialValue: setting.hasFrame,
        labelBuilder: (hasFrame) => hasFrame ? 'Device Frame' : 'None',
        codec: FieldCodec(
          toParam: (hasFrame) => hasFrame.toString(),
          toValue: (param) => param == 'true',
        ),
        onChanged: (hasFrame) {
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
