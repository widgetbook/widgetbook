import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

DeviceInfo? mapDeviceToDeviceInfo(Device device) {
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

  final mappedDevice = map[device];

  return mappedDevice;
}

DeviceFrameBuilderFunction get defaultDeviceFrameBuilder => (
      BuildContext context,
      Device device,
      WidgetbookFrame frame,
      Widget child,
    ) {
      if (frame == WidgetbookFrame.defaultFrame()) {
        return WidgetbookDeviceFrame(
          device: device,
          child: child,
        );
      }

      if (frame == WidgetbookFrame.deviceFrame()) {
        final deviceInfo = mapDeviceToDeviceInfo(device);
        if (deviceInfo == null) {
          return WidgetbookDeviceFrame(
            device: device,
            child: child,
          );
        }
        return DeviceFrame(
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
  Widget child,
);
