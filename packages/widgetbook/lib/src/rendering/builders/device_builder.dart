import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

DeviceInfo mapDeviceToDeviceInfo(Device device) {
  final map = {
    Apple.iPhone12Mini: Devices.ios.iPhone12Mini,
    Apple.iPhone12: Devices.ios.iPhone12,
    Apple.iPhone12ProMax: Devices.ios.iPhone12ProMax,
    Apple.iPhone13Mini: Devices.ios.iPhone13Mini,
    Apple.iPhone13: Devices.ios.iPhone13,
    Apple.iPhone13ProMax: Devices.ios.iPhone13ProMax,
    Apple.iPhoneSE2020: Devices.ios.iPhoneSE,
    // not sure what to map this device to
    // Apple.iPadAir9Inch: Devices.ios.iPadAir4,
    Apple.iPad10Inch: Devices.ios.iPad,
    Apple.iPadPro11Inch: Devices.ios.iPadPro11Inches,
  };

  final mappedDevice = map[device] ??
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

DeviceFrameBuilderFunction get defaultDeviceFrameBuilder => (
      BuildContext context,
      Device device,
      WidgetbookFrame frame,
      Orientation orientation,
      Widget child,
    ) {
      if (frame == WidgetbookFrame.defaultFrame()) {
        return WidgetbookDeviceFrame(
          orientation: orientation,
          device: device,
          child: child,
        );
      }

      if (frame == WidgetbookFrame.deviceFrame()) {
        final deviceInfo = mapDeviceToDeviceInfo(device);
        return DeviceFrame(
          orientation: orientation,
          device: deviceInfo,
          screen: child,
        );
      }

      return child;
    };

typedef DeviceFrameBuilderFunction = Widget Function(
  BuildContext context,
  Device device,
  WidgetbookFrame frame,
  Orientation orientation,
  Widget child,
);
