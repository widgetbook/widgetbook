import 'package:flutter/foundation.dart';

import 'viewport_data.dart';

abstract class Viewports {
  static const Null none = null;

  static const iphoneSE = ViewportData(
    id: 'iphone-se-2nd',
    name: 'iPhone SE (2nd generation)',
    width: 375,
    height: 667,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
  );

  static const iphone11 = ViewportData(
    id: 'iphone-11',
    name: 'iPhone 11',
    width: 414,
    height: 896,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
  );

  static const iphone12 = ViewportData(
    id: 'iphone-12',
    name: 'iPhone 12',
    width: 390,
    height: 844,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
  );

  static const iphone13ProMax = ViewportData(
    id: 'iphone-13-pro-max',
    name: 'iPhone 13 Pro Max',
    width: 428,
    height: 926,
    pixelRatio: 3,
    platform: TargetPlatform.iOS,
  );

  static const ipad = ViewportData(
    id: 'ipad',
    name: 'iPad',
    width: 768,
    height: 1024,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
  );

  static const ipadPro = ViewportData(
    id: 'ipad-pro-12.9',
    name: 'iPad Pro (12.9-inch)',
    width: 1024,
    height: 1366,
    pixelRatio: 2,
    platform: TargetPlatform.iOS,
  );

  static const galaxyS10 = ViewportData(
    id: 'galaxy-s10',
    name: 'Galaxy S10',
    width: 360,
    height: 740,
    pixelRatio: 3,
    platform: TargetPlatform.android,
  );

  static const pixel2 = ViewportData(
    id: 'pixel-2',
    name: 'Pixel 2',
    width: 411,
    height: 731,
    pixelRatio: 3,
    platform: TargetPlatform.android,
  );

  static const pixel4a = ViewportData(
    id: 'pixel-4a',
    name: 'Pixel 4a',
    width: 360,
    height: 640,
    pixelRatio: 3,
    platform: TargetPlatform.android,
  );

  static const pixel5 = ViewportData(
    id: 'pixel-5',
    name: 'Pixel 5',
    width: 411,
    height: 823,
    pixelRatio: 3,
    platform: TargetPlatform.android,
  );

  static const galaxyTabS7Plus = ViewportData(
    id: 'galaxy-tab-s7-plus',
    name: 'Galaxy Tab S7+',
    width: 832,
    height: 1200,
    pixelRatio: 3,
    platform: TargetPlatform.android,
  );

  static const all = <ViewportData?>[
    none,
    iphoneSE,
    iphone11,
    iphone12,
    iphone13ProMax,
    ipad,
    ipadPro,
    galaxyS10,
    pixel2,
    pixel4a,
    pixel5,
    galaxyTabS7Plus,
  ];
}
