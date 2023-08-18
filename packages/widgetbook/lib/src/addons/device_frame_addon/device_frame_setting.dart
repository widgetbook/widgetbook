import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

class DeviceFrameSetting {
  DeviceFrameSetting({
    required this.device,
    this.orientation = Orientation.portrait,
    this.hasFrame = true,
  });

  final DeviceInfo device;
  final Orientation orientation;
  final bool hasFrame;
}
