import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
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
