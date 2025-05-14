import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import '../viewport_data.dart';

abstract class AndroidViewports {
  static const all = [
    ...phones,
    ...tablets,
  ];

  static const phones = [
    onePlus8Pro,
    samsungGalaxyA50,
    samsungGalaxyNote20,
    samsungGalaxyNote20Ultra,
    samsungGalaxyS20,
    sonyXperia1II,
  ];

  static const tablets = [
    smallTablet,
    mediumTablet,
    largeTablet,
  ];

  static const onePlus8Pro = ViewportData(
    id: 'one-plus-8-pro',
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

  static const samsungGalaxyA50 = ViewportData(
    id: 'samsung-galaxy-a50',
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

  static const samsungGalaxyNote20 = ViewportData(
    id: 'samsung-galaxy-note20',
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

  static const samsungGalaxyNote20Ultra = ViewportData(
    id: 'samsung-galaxy-note20-ultra',
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

  static const samsungGalaxyS20 = ViewportData(
    id: 'samsung-galaxy-s20',
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

  static const sonyXperia1II = ViewportData(
    id: 'sony-xperia-1-ii',
    name: 'Sony Xperia 1 II',
    width: 411,
    height: 960,
    pixelRatio: 4,
    platform: TargetPlatform.android,
    safeAreas: const EdgeInsets.only(
      top: 24,
    ),
  );

  static const smallTablet = ViewportData(
    id: 'small-android-tablet',
    name: 'Small Tablet',
    width: 800,
    height: 1280,
    pixelRatio: 2,
    platform: TargetPlatform.android,
    safeAreas: const EdgeInsets.only(
      top: 24,
    ),
  );

  static const mediumTablet = ViewportData(
    id: 'medium-android-tablet',
    name: 'Medium Android Tablet',
    width: 1024,
    height: 1350,
    pixelRatio: 2,
    platform: TargetPlatform.android,
    safeAreas: const EdgeInsets.only(
      top: 24,
    ),
  );

  static const largeTablet = ViewportData(
    id: 'large-android-tablet',
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
