import 'package:widgetbook_models/src/devices/device.dart';
import 'package:widgetbook_models/src/devices/device_size.dart';
import 'package:widgetbook_models/src/devices/resolution.dart';

/// Collection of Apple devices
///
/// For apple phone sizes and layout see:
/// https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/
class Apple {
  /// A 12.9 inch iPad Pro
  static const Device iPadPro12inch = Device.tablet(
    name: '12.9" iPad Pro',
    resolution: Resolution(
      nativeSize: DeviceSize(
        width: 2048,
        height: 2732,
      ),
      scaleFactor: 2,
    ),
  );

  /// A 11 inch iPad Pro
  static const Device iPadPro11inch = Device.tablet(
    name: '11" iPad Pro',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1668, height: 2388),
      scaleFactor: 2,
    ),
  );

  /// A 10.5 inch iPad Pro
  static const Device iPadPro10inch = Device.tablet(
    name: '10.5" iPad Pro',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1668, height: 2388),
      scaleFactor: 2,
    ),
  );

  /// A 9.7 inch iPad Pro
  static const Device iPadPro9inch = Device.tablet(
    name: '9.7" iPad Pro',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 768, height: 1024),
      scaleFactor: 2,
    ),
  );

  /// A 7.9 inch iPad Mini
  static const Device iPadMini = Device.tablet(
    name: '7.9" iPad mini',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 768, height: 1024),
      scaleFactor: 2,
    ),
  );

  /// A 10.5 inch iPad Air
  static const Device iPadAir10Inch = Device.tablet(
    name: '10.5" iPad Air',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1668, height: 2224),
      scaleFactor: 2,
    ),
  );

  /// A 9 inch iPad Air
  static const Device iPadAir9Inch = Device.tablet(
    name: '9.7" iPad Air',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1536, height: 2048),
      scaleFactor: 2,
    ),
  );

  /// A iPhone 11
  static const Device iPhone11 = Device.mobile(
    name: 'iPhone 11',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 828, height: 1792),
      scaleFactor: 2,
    ),
  );

  /// A iPhone 12
  static const Device iPhone12 = Device.mobile(
    name: 'iPhone 12',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1170, height: 2532),
      scaleFactor: 3,
    ),
  );

  /// A iPhone 12 Pro
  static const Device iPhone12pro = Device.mobile(
    name: 'iPhone 12 Pro',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1170, height: 2532),
      scaleFactor: 3,
    ),
  );

  /// A iPhone 12 Mini
  static const Device iPhone12mini = Device.mobile(
    name: 'iPhone 12 Mini',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1125, height: 2436),
      scaleFactor: 3,
    ),
  );
}
