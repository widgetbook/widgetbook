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
  static const Device iPadPro11Inch = Device.tablet(
    name: '11" iPad Pro',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1668, height: 2388),
      scaleFactor: 2,
    ),
  );

  /// A 10.5 inch iPad Pro
  static const Device iPadPro10Inch = Device.tablet(
    name: '10.5" iPad Pro',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1668, height: 2388),
      scaleFactor: 2,
    ),
  );

  /// A 9.7 inch iPad Pro
  static const Device iPadPro9Inch = Device.tablet(
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

  /// A 9.7 inch iPad Air
  static const Device iPadAir9Inch = Device.tablet(
    name: '9.7" iPad Air',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1536, height: 2048),
      scaleFactor: 2,
    ),
  );

  /// A 10.2 inch iPad
  static const Device iPad10Inch = Device.tablet(
    name: '10.2" iPad',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1620, height: 2160),
      scaleFactor: 2,
    ),
  );

  /// A 9.7 inch iPad
  static const Device iPad9Inch = Device.tablet(
    name: '9.7" iPad',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1536, height: 2048),
      scaleFactor: 2,
    ),
  );

  /// A iPhone 12 Pro Max
  static const Device iPhone12ProMax = Device.mobile(
    name: 'iPhone 12 Pro Max',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1284, height: 2778),
      scaleFactor: 3,
    ),
  );

  /// A iPhone 12 Pro
  static const Device iPhone12Pro = Device.mobile(
    name: 'iPhone 12 Pro',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1170, height: 2532),
      scaleFactor: 3,
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

  /// A iPhone 12 Mini
  static const Device iPhone12Mini = Device.mobile(
    name: 'iPhone 12 Mini',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1125, height: 2436),
      scaleFactor: 3,
    ),
  );

  /// A iPhone 11 Pro Max
  static const Device iPhone11ProMax = Device.mobile(
    name: 'iPhone 11 Pro Max',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1242, height: 2688),
      scaleFactor: 3,
    ),
  );

  /// A iPhone 12 Pro
  static const Device iPhone11Pro = Device.mobile(
    name: 'iPhone 11 Pro',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1125, height: 2436),
      scaleFactor: 3,
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

  /// A iPhone Xs Max
  static const Device iPhoneXsMax = Device.mobile(
    name: 'iPhone Xs Max',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1242, height: 2688),
      scaleFactor: 3,
    ),
  );

  /// A iPhone Xs
  static const Device iPhoneXs = Device.mobile(
    name: 'iPhone Xs',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1125, height: 2436),
      scaleFactor: 3,
    ),
  );

  /// A iPhone Xr
  static const Device iPhoneXr = Device.mobile(
    name: 'iPhone Xr',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 828, height: 1792),
      scaleFactor: 2,
    ),
  );

  /// A iPhone X
  static const Device iPhoneX = Device.mobile(
    name: 'iPhone X',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1125, height: 2436),
      scaleFactor: 3,
    ),
  );

  /// A iPhone 8 Plus
  static const Device iPhone8Plus = Device.mobile(
    name: 'iPhone 8 Plus',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1080, height: 1920),
      scaleFactor: 3,
    ),
  );

  /// A iPhone 8
  static const Device iPhone8 = Device.mobile(
    name: 'iPhone 8',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 750, height: 1334),
      scaleFactor: 2,
    ),
  );

  /// A iPhone 7 Plus
  static const Device iPhone7Plus = Device.mobile(
    name: 'iPhone 7 Plus',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1080, height: 1920),
      scaleFactor: 3,
    ),
  );

  /// A iPhone 7
  static const Device iPhone7 = Device.mobile(
    name: 'iPhone 7',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 750, height: 1334),
      scaleFactor: 2,
    ),
  );

  /// A iPhone 6s Plus
  static const Device iPhone6sPlus = Device.mobile(
    name: 'iPhone 6s Plus',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1080, height: 1920),
      scaleFactor: 3,
    ),
  );

  /// A iPhone 6 Plus
  static const Device iPhone6Plus = Device.mobile(
    name: 'iPhone 6 Plus',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1080, height: 1920),
      scaleFactor: 3,
    ),
  );

  /// A iPhone 6
  static const Device iPhone6 = Device.mobile(
    name: 'iPhone 6',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 750, height: 1334),
      scaleFactor: 2,
    ),
  );

  /// A 4.7 Inch iPhone SE
  static const Device iPhoneSE2020 = Device.mobile(
    name: 'iPhone SE (2020)',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 750, height: 1334),
      scaleFactor: 2,
    ),
  );

  /// A 4 Inch iPhone SE
  static const Device iPhoneSE4Inch = Device.mobile(
    name: 'iPhone SE 4"',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 640, height: 1136),
      scaleFactor: 2,
    ),
  );

  /// A iPod touch 5th generation and later
  static const Device iPod = Device.mobile(
    name: 'iPod 5th generation and later',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 640, height: 1136),
      scaleFactor: 2,
    ),
  );

  /// A 13.3 Inch MacBook
  static const Device macBook13Inch = Device.desktop(
    name: 'MacBook 13"',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 2560, height: 1600),
      scaleFactor: 2,
    ),
  );

  /// A 14.2 Inch MacBook
  static const Device macBook14Inch = Device.desktop(
    name: 'MacBook 14"',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 3024, height: 1964),
      scaleFactor: 2,
    ),
  );

  /// A 15.4 Inch MacBook
  static const Device macBook15Inch = Device.desktop(
    name: 'MacBook 15"',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 2880, height: 1800),
      scaleFactor: 2,
    ),
  );

  /// A 16.2 Inch MacBook
  static const Device macBook16Inch = Device.desktop(
    name: 'MacBook 16"',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 3456, height: 2234),
      scaleFactor: 2,
    ),
  );

  /// A 21.5 Inch iMac Slim Unibody
  static const Device iMacSlimUnibody21Inch = Device.desktop(
    name: 'iMac Slim Unibody 21.5"',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1920, height: 1080),
      scaleFactor: 2,
    ),
  );

  /// A 27 Inch iMac Slim Unibody
  static const Device iMacSlimUnibody27Inch = Device.desktop(
    name: 'iMac Slim Unibody 27"',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 2560, height: 1440),
      scaleFactor: 2,
    ),
  );

  /// A 21.5 Inch iMac Retina
  static const Device iMacRetina21Inch = Device.desktop(
    name: 'iMac Retina 21.5"',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 4096, height: 2304),
      scaleFactor: 2,
    ),
  );

  /// A 27 Inch iMac Retina
  static const Device iMacRetina27Inch = Device.desktop(
    name: 'iMac Slim Unibody 27"',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 5120, height: 2880),
      scaleFactor: 2,
    ),
  );

  /// A iMac M1
  static const Device iMacM1 = Device.desktop(
    name: 'iMac M1',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 4480, height: 2520),
      scaleFactor: 2,
    ),
  );

  /// A Pro Display XDR
  static const Device proDisplayXDR = Device.desktop(
    name: 'Pro Display XDR',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 6016, height: 3384),
      scaleFactor: 2,
    ),
  );
}
