import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/device_addon/frame_builders/frame_builder.dart';
import 'package:widgetbook/widgetbook.dart';

class WidgetbookFrameBuilder extends FrameBuilder {
  WidgetbookFrameBuilder({
    required List<Device> devices,
  }) : super(
          name: 'Widgetbook',
          devices: devices,
        );

  @override
  Widget builder(BuildContext context, Widget child) {
    final device = context.device;
    return SizedBox(
      width: device.resolution.logicalSize.width,
      height: device.resolution.logicalSize.height,
      child: child,
    );
  }
}
