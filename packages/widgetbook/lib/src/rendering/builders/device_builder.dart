import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

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

      return child;
    };

typedef DeviceFrameBuilderFunction = Widget Function(
  BuildContext context,
  Device device,
  WidgetbookFrame frame,
  Widget child,
);
