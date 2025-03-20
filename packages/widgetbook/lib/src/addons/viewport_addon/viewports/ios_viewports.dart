import 'package:flutter/foundation.dart';

import '../viewport_data.dart';

abstract class IosViewports {
  static const all = [
    ...phones,
    ...tablets,
  ];

  static const phones = [
    iPhone12Mini,
    iPhone12,
    iPhone12ProMax,
    iPhone13Mini,
    iPhone13,
    iPhone13ProMax,
    iPhoneSE,
  ];

  static const tablets = [
    iPadAir4,
    iPad,
    iPadPro11Inches,
    iPad12InchesGen2,
    iPad12InchesGen4,
  ];

  static const iPhone12Mini = ViewportData(
    id: 'iphone-12-mini',
    name: 'iPhone 12 Mini',
    width: 375,
    height: 812,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
  );

  static const iPhone12 = ViewportData(
    id: 'iphone-12',
    name: 'iPhone 12',
    width: 390,
    height: 844,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
  );

  static const iPhone12ProMax = ViewportData(
    id: 'iphone-12-pro-max',
    name: 'iPhone 12 Pro Max',
    width: 428,
    height: 926,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
  );

  static const iPhone13Mini = ViewportData(
    id: 'iphone-13-mini',
    name: 'iPhone 13 Mini',
    width: 375,
    height: 812,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
  );

  static const iPhone13 = ViewportData(
    id: 'iphone-13',
    name: 'iPhone 13',
    width: 390,
    height: 844,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
  );

  static const iPhone13ProMax = ViewportData(
    id: 'iphone-13-pro-max',
    name: 'iPhone 13 Pro Max',
    width: 428,
    height: 926,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
  );

  static const iPhoneSE = ViewportData(
    id: 'iphone-se',
    name: 'iPhone SE',
    width: 375,
    height: 667,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
  );

  static const iPadAir4 = ViewportData(
    id: 'ipad-air-4',
    name: 'iPad Air 4',
    width: 820,
    height: 1180,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
  );

  static const iPad = ViewportData(
    id: 'ipad',
    name: 'iPad',
    width: 810,
    height: 1080,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
  );

  static const iPadPro11Inches = ViewportData(
    id: 'ipad-pro-11inches',
    name: 'iPad Pro (11")',
    width: 834,
    height: 1194,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
  );

  static const iPad12InchesGen2 = ViewportData(
    id: 'ipad-pro-12inches-gen2',
    name: 'iPad Pro (12" gen 2)',
    width: 1024,
    height: 1366,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
  );

  static const iPad12InchesGen4 = ViewportData(
    id: 'ipad-pro-12inches-gen4',
    name: 'iPad Pro (12" gen 4)',
    width: 1024,
    height: 1366,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
  );
}
