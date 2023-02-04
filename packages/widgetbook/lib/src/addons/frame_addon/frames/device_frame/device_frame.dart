import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class DefaultDeviceFrame extends Frame {
  DefaultDeviceFrame({required DeviceSetting setting})
      : super(
          name: 'Device Frame',
          addon: DeviceAddon(setting: setting),
          getDefaultQueryParameters: {
            'orientation': Orientation.portrait.name,
            'device': setting.activeDevice.name,
          },
        );

  @override
  Widget builder(BuildContext context, Widget child) {
    return DeviceFrame(
      key: const Key('device_frame'),
      orientation: context.orientation,
      device: mapDeviceToDeviceInfo(context.device),
      screen: child,
    );
  }
}

DeviceInfo mapDeviceToDeviceInfo(Device device) {
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
