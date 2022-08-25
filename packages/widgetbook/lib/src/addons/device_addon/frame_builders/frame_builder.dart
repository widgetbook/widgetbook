import 'package:flutter/material.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

abstract class FrameBuilder {
  FrameBuilder({
    required this.name,
    required this.devices,
  });

  final String name;
  final List<Device> devices;

  bool get hasDevices => devices.isNotEmpty;

  Widget builder(BuildContext context, Widget child);
}
