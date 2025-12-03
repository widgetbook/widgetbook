import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import '../viewport_data.dart';

/// A collection of predefined Android viewports.
abstract class AndroidViewports {
  /// A list of all Android viewports.
  static const all = [
    ...phones,
    ...tablets,
  ];

  /// A list of all Android phones.
  static const phones = [
    onePlus8Pro,
    samsungGalaxyA50,
    samsungGalaxyNote20,
    samsungGalaxyNote20Ultra,
    samsungGalaxyS20,
    sonyXperia1II,
  ];

  /// A list of all Android tablets.
  static const tablets = [
    smallTablet,
    mediumTablet,
    largeTablet,
  ];

  /// Represents a viewport for the OnePlus 8 Pro device.
  static const onePlus8Pro = ViewportData(
    name: 'OnePlus 8 Pro',
    width: 360,
    height: 800,
    pixelRatio: 4,
    platform: TargetPlatform.android,
    safeAreas: const EdgeInsets.only(
      top: 40,
      bottom: 20,
    ),
  );

  /// Represents a viewport for the Samsung Galaxy A50 device.
  static const samsungGalaxyA50 = ViewportData(
    name: 'Samsung Galaxy A50',
    width: 412,
    height: 892,
    pixelRatio: 2.625,
    platform: TargetPlatform.android,
    safeAreas: const EdgeInsets.only(
      top: 32,
      bottom: 32,
    ),
  );

  /// Represents a viewport for the Samsung Galaxy Note 20 device.
  static const samsungGalaxyNote20 = ViewportData(
    name: 'Samsung Galaxy Note 20',
    width: 412,
    height: 916,
    pixelRatio: 2.625,
    platform: TargetPlatform.android,
    safeAreas: const EdgeInsets.only(
      top: 48,
      bottom: 32,
    ),
  );

  /// Represents a viewport for the Samsung Galaxy Note 20 Ultra device.
  static const samsungGalaxyNote20Ultra = ViewportData(
    name: 'Samsung Galaxy Note 20 Ultra',
    width: 412,
    height: 883,
    pixelRatio: 3.5,
    platform: TargetPlatform.android,
    safeAreas: const EdgeInsets.only(
      top: 36,
      bottom: 24,
    ),
  );

  /// Represents a viewport for the Samsung Galaxy S20 device.
  static const samsungGalaxyS20 = ViewportData(
    name: 'Samsung Galaxy S20',
    width: 360,
    height: 800,
    pixelRatio: 4,
    platform: TargetPlatform.android,
    safeAreas: const EdgeInsets.only(
      top: 32,
      bottom: 32,
    ),
  );

  /// Represents a viewport for the Sony Xperia 1 II device.
  static const sonyXperia1II = ViewportData(
    name: 'Sony Xperia 1 II',
    width: 411,
    height: 960,
    pixelRatio: 4,
    platform: TargetPlatform.android,
    safeAreas: const EdgeInsets.only(
      top: 24,
    ),
  );

  /// Represents a viewport for a small Android tablet.
  static const smallTablet = ViewportData(
    name: 'Small Android Tablet',
    width: 800,
    height: 1280,
    pixelRatio: 2,
    platform: TargetPlatform.android,
    safeAreas: const EdgeInsets.only(
      top: 24,
    ),
  );

  /// Represents a viewport for a medium Android tablet.
  static const mediumTablet = ViewportData(
    name: 'Medium Android Tablet',
    width: 1024,
    height: 1350,
    pixelRatio: 2,
    platform: TargetPlatform.android,
    safeAreas: const EdgeInsets.only(
      top: 24,
    ),
  );

  /// Represents a viewport for a large Android tablet.
  static const largeTablet = ViewportData(
    name: 'Large Android Tablet',
    width: 1280,
    height: 1880,
    pixelRatio: 2,
    platform: TargetPlatform.android,
    safeAreas: const EdgeInsets.only(
      top: 24,
    ),
  );
}
