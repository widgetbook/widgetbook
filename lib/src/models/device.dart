import 'package:widgetbook/src/models/resolution.dart';

enum DeviceType {
  watch,
  mobile,
  tablet,
  desktop,
  unknown,
}

class Device {
  final String name;
  final Resolution resolution;
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

class Samsung {
  static const Device s21ultra = Device(
    name: 'S21 Ultra',
    type: DeviceType.mobile,
    resolution: Resolution(
      height: 3200,
      width: 1440,
      scaleFactor: 3.75,
    ),
  );

  static const Device s10 = Device(
    name: 'S10',
    type: DeviceType.mobile,
    resolution: Resolution(
      height: 3050,
      width: 1440,
      scaleFactor: 4,
    ),
  );
}

// For apple phone sizes and layout see:
// https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/
class Apple {
  static const Device iPadPro12inch = Device(
    name: '12.9" iPad Pro',
    type: DeviceType.tablet,
    resolution: Resolution(
      height: 2732,
      width: 2048,
      scaleFactor: 2,
    ),
  );

  static const Device iPadPro11inch = Device(
    name: '11" iPad Pro',
    type: DeviceType.tablet,
    resolution: Resolution(
      height: 2388,
      width: 1668,
      scaleFactor: 2,
    ),
  );

  static const Device iPadPro10inch = Device(
    name: '10.5" iPad Pro',
    type: DeviceType.tablet,
    resolution: Resolution(
      height: 2388,
      width: 1668,
      scaleFactor: 2,
    ),
  );

  static const Device iPadPro9inch = Device(
    name: '9.7" iPad Pro',
    type: DeviceType.tablet,
    resolution: Resolution(
      height: 1024,
      width: 768,
      scaleFactor: 2,
    ),
  );

  static const Device iPadMini = Device(
    name: '7.9" iPad mini',
    type: DeviceType.tablet,
    resolution: Resolution(
      height: 1024,
      width: 768,
      scaleFactor: 2,
    ),
  );

  static const Device iPadAir10Inch = Device(
    name: '10.5" iPad Air',
    type: DeviceType.tablet,
    resolution: Resolution(
      height: 2224,
      width: 1668,
      scaleFactor: 2,
    ),
  );

  static const Device iPadAir9Inch = Device(
    name: '9.7" iPad Air',
    type: DeviceType.tablet,
    resolution: Resolution(
      height: 2048,
      width: 1536,
      scaleFactor: 2,
    ),
  );

  static const Device iPhone11 = Device(
    name: 'iPhone 11',
    type: DeviceType.mobile,
    resolution: Resolution(
      height: 1792,
      width: 828,
      scaleFactor: 2,
    ),
  );

  static const Device iPhone12 = Device(
    name: 'iPhone 12',
    type: DeviceType.mobile,
    resolution: Resolution(
      height: 2532,
      width: 1170,
      scaleFactor: 3,
    ),
  );

  static const Device iPhone12pro = Device(
    name: 'iPhone 12 Pro',
    type: DeviceType.mobile,
    resolution: Resolution(
      height: 2532,
      width: 1170,
      scaleFactor: 3,
    ),
  );

  static const Device iPhone12mini = Device(
    name: 'iPhone 12 Mini',
    type: DeviceType.mobile,
    resolution: Resolution(
      height: 2436,
      width: 1125,
      scaleFactor: 3,
    ),
  );
}
