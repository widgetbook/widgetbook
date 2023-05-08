import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../fields/fields.dart';

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
      DropdownField<Device?>(
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
      device: _mapDeviceToDeviceInfo(setting.activeDevice!),
      isFrameVisible: setting.hasFrame,
      screen: child,
    );
  }

  DeviceInfo _mapDeviceToDeviceInfo(Device device) {
    final map = {
      Apple.iPhone12Mini.name: Devices.ios.iPhone12Mini,
      Apple.iPhone12.name: Devices.ios.iPhone12,
      Apple.iPhone12ProMax.name: Devices.ios.iPhone12ProMax,
      Apple.iPhone13Mini.name: Devices.ios.iPhone13Mini,
      Apple.iPhone13.name: Devices.ios.iPhone13,
      Apple.iPhone13ProMax.name: Devices.ios.iPhone13ProMax,
      Apple.iPhoneSE2020.name: Devices.ios.iPhoneSE,
      // not sure what to map this device to
      // Apple.iPadAir9Inch: Devices.ios.iPadAir4,
      Apple.iPad10Inch.name: Devices.ios.iPad,
      Apple.iPadPro11Inch.name: Devices.ios.iPadPro11Inches,
    };

    final mappedDevice = map[device.name] ??
        DeviceInfo.genericPhone(
          platform: TargetPlatform.iOS,
          id: 'custom',
          name: 'custom',
          screenSize: Size(
            device.resolution.logicalSize.width,
            device.resolution.logicalSize.height,
          ),
          pixelRatio: device.resolution.scaleFactor,
        );

    return mappedDevice;
  }
}
