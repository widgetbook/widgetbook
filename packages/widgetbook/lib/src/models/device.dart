import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/resolution.dart';

/// Category of different device types.
enum DeviceType {
  watch,
  mobile,
  tablet,
  desktop,
  unknown,
}

/// A virtual device that will rendered when a story is previewed
class Device {
  /// For Instance iPhone 12 or Samsung S10.
  final String name;

  /// Specifies the native resolution (of the device screen)
  /// and the logical resolution (for rendering a preview on the device).
  final Resolution resolution;

  /// Categorizes the Device.
  /// For instance mobile or tablet.
  /// This is used to display an appropriate icon in the device bar.
  final DeviceType type;

  const Device({
    required this.name,
    required this.resolution,
    required this.type,
  });

  factory Device.custom({
    required String name,
    required Resolution resolution,
  }) {
    return Device(
      name: name,
      resolution: resolution,
      type: DeviceType.unknown,
    );
  }
}

/// Collection of Samsung devices
class Samsung {
  static const Device s21ultra = Device(
    name: 'S21 Ultra',
    type: DeviceType.mobile,
    resolution: Resolution(
      nativeSize: Size(1440, 3200),
      scaleFactor: 3.75,
    ),
  );

  static const Device s10 = Device(
    name: 'S10',
    type: DeviceType.mobile,
    resolution: Resolution(
      nativeSize: Size(1440, 3050),
      scaleFactor: 4,
    ),
  );
}

// For apple phone sizes and layout see:
// https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/

/// Collection of Apple devices
class Apple {
  static const Device iPadPro12inch = Device(
    name: '12.9" iPad Pro',
    type: DeviceType.tablet,
    resolution: Resolution(
      nativeSize: Size(2048, 2732),
      scaleFactor: 2,
    ),
  );

  static const Device iPadPro11inch = Device(
    name: '11" iPad Pro',
    type: DeviceType.tablet,
    resolution: Resolution(
      nativeSize: Size(1668, 2388),
      scaleFactor: 2,
    ),
  );

  static const Device iPadPro10inch = Device(
    name: '10.5" iPad Pro',
    type: DeviceType.tablet,
    resolution: Resolution(
      nativeSize: Size(1668, 2388),
      scaleFactor: 2,
    ),
  );

  static const Device iPadPro9inch = Device(
    name: '9.7" iPad Pro',
    type: DeviceType.tablet,
    resolution: Resolution(
      nativeSize: Size(768, 1024),
      scaleFactor: 2,
    ),
  );

  static const Device iPadMini = Device(
    name: '7.9" iPad mini',
    type: DeviceType.tablet,
    resolution: Resolution(
      nativeSize: Size(768, 1024),
      scaleFactor: 2,
    ),
  );

  static const Device iPadAir10Inch = Device(
    name: '10.5" iPad Air',
    type: DeviceType.tablet,
    resolution: Resolution(
      nativeSize: Size(1668, 2224),
      scaleFactor: 2,
    ),
  );

  static const Device iPadAir9Inch = Device(
    name: '9.7" iPad Air',
    type: DeviceType.tablet,
    resolution: Resolution(
      nativeSize: Size(1536, 2048),
      scaleFactor: 2,
    ),
  );

  static const Device iPhone11 = Device(
    name: 'iPhone 11',
    type: DeviceType.mobile,
    resolution: Resolution(
      nativeSize: Size(828, 1792),
      scaleFactor: 2,
    ),
  );

  static const Device iPhone12 = Device(
    name: 'iPhone 12',
    type: DeviceType.mobile,
    resolution: Resolution(
      nativeSize: Size(1170, 2532),
      scaleFactor: 3,
    ),
  );

  static const Device iPhone12pro = Device(
    name: 'iPhone 12 Pro',
    type: DeviceType.mobile,
    resolution: Resolution(
      nativeSize: Size(1170, 2532),
      scaleFactor: 3,
    ),
  );

  static const Device iPhone12mini = Device(
    name: 'iPhone 12 Mini',
    type: DeviceType.mobile,
    resolution: Resolution(
      nativeSize: Size(1125, 2436),
      scaleFactor: 3,
    ),
  );
}
