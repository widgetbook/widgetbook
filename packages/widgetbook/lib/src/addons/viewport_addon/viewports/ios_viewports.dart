import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import '../viewport_data.dart';

/// A collection of predefined iOS viewports.
abstract class IosViewports {
  /// A list of all iOS viewports.
  static const all = [
    ...phones,
    ...tablets,
  ];

  /// A list of all iOS phones.
  static const phones = [
    iPhone12Mini,
    iPhone12,
    iPhone12ProMax,
    iPhone13Mini,
    iPhone13,
    iPhone13ProMax,
    iPhoneSE,
  ];

  /// A list of all iOS tablets.
  static const tablets = [
    iPadAir4,
    iPad,
    iPadPro11Inches,
    iPad12InchesGen2,
    iPad12InchesGen4,
  ];

  /// Represents a viewport for the iPhone 12 Mini device.
  static const iPhone12Mini = ViewportData(
    name: 'iPhone 12 Mini',
    width: 375,
    height: 812,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
    safeAreas: const EdgeInsets.only(
      top: 44,
      bottom: 34,
    ),
  );

  /// Represents a viewport for the iPhone 12 device.
  static const iPhone12 = ViewportData(
    name: 'iPhone 12',
    width: 390,
    height: 844,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
    safeAreas: const EdgeInsets.only(
      top: 24,
      bottom: 20,
    ),
  );

  /// Represents a viewport for the iPhone 12 Pro Max device.
  static const iPhone12ProMax = ViewportData(
    name: 'iPhone 12 Pro Max',
    width: 428,
    height: 926,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
    safeAreas: const EdgeInsets.only(
      top: 44,
      bottom: 34,
    ),
  );

  /// Represents a viewport for the iPhone 13 Mini device.
  static const iPhone13Mini = ViewportData(
    name: 'iPhone 13 Mini',
    width: 375,
    height: 812,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
    safeAreas: const EdgeInsets.only(
      top: 47,
      bottom: 34,
    ),
  );

  /// Represents a viewport for the iPhone 13 device.
  static const iPhone13 = ViewportData(
    name: 'iPhone 13',
    width: 390,
    height: 844,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
    safeAreas: const EdgeInsets.only(
      top: 47,
      bottom: 34,
    ),
  );

  /// Represents a viewport for the iPhone 13 Pro Max device.
  static const iPhone13ProMax = ViewportData(
    name: 'iPhone 13 Pro Max',
    width: 428,
    height: 926,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
    safeAreas: const EdgeInsets.only(
      top: 47,
      bottom: 34,
    ),
  );

  /// Represents a viewport for the iPhone SE device.
  static const iPhoneSE = ViewportData(
    name: 'iPhone SE',
    width: 375,
    height: 667,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
    safeAreas: const EdgeInsets.only(
      top: 20,
    ),
  );

  /// Represents a viewport for the iPad Air 4 device.
  static const iPadAir4 = ViewportData(
    name: 'iPad Air 4',
    width: 820,
    height: 1180,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
    safeAreas: const EdgeInsets.only(
      top: 20,
    ),
  );

  /// Represents a viewport for the iPad device.
  static const iPad = ViewportData(
    name: 'iPad',
    width: 810,
    height: 1080,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
    safeAreas: const EdgeInsets.only(
      top: 20,
    ),
  );

  /// Represents a viewport for the iPad Pro (11") device.
  static const iPadPro11Inches = ViewportData(
    name: 'iPad Pro (11")',
    width: 834,
    height: 1194,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
    safeAreas: const EdgeInsets.only(
      top: 20,
    ),
  );

  /// Represents a viewport for the iPad Pro (12" gen 2) device.
  static const iPad12InchesGen2 = ViewportData(
    name: 'iPad Pro (12" gen 2)',
    width: 1024,
    height: 1366,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
    safeAreas: const EdgeInsets.only(
      top: 20,
    ),
  );

  /// Represents a viewport for the iPad Pro (12" gen 4) device.
  static const iPad12InchesGen4 = ViewportData(
    name: 'iPad Pro (12" gen 4)',
    width: 1024,
    height: 1366,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
    safeAreas: const EdgeInsets.only(
      top: 24,
      bottom: 20,
    ),
  );
}
