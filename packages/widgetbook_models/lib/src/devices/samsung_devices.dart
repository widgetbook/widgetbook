import 'package:flutter/material.dart';
import 'package:widgetbook_models/src/devices/device.dart';
import 'package:widgetbook_models/src/devices/resolution.dart';

/// Collection of Samsung devices
class Samsung {
  /// A Samsung Galaxy S21 Ultra
  static const Device s21ultra = Device.mobile(
    name: 'S21 Ultra',
    resolution: Resolution(
      nativeSize: Size(1440, 3200),
      scaleFactor: 3.75,
    ),
  );

  /// A Samsung Galaxy S10
  static const Device s10 = Device.mobile(
    name: 'S10',
    resolution: Resolution(
      nativeSize: Size(1440, 3050),
      scaleFactor: 4,
    ),
  );
}
