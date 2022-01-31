import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

DeviceFrameBuilderFunction get defaultDeviceFrameBuilder => (
      BuildContext context,
      Device device,
      DeviceFrame deviceFrame,
      Widget child,
    ) {
      if (deviceFrame == DeviceFrame.widgetbook()) {
        return WidgetbookDeviceFrame(
          device: device,
          child: child,
        );
      }

      return child;
    };

typedef DeviceFrameBuilderFunction = Widget Function(
  BuildContext context,
  Device device,
  DeviceFrame deviceFrame,
  Widget child,
);
