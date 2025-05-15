import 'package:flutter/services.dart';

import '../viewport_data.dart';

abstract class MacosViewports {
  static const all = [
    desktop,
    macbookPro,
  ];

  static const desktop = ViewportData(
    name: 'macOS Desktop',
    width: 1920,
    height: 1080,
    pixelRatio: 2,
    platform: TargetPlatform.macOS,
  );

  static const macbookPro = ViewportData(
    name: 'MacBook Pro',
    width: 1800 - 30,
    height: 1000 - 30,
    pixelRatio: 2,
    platform: TargetPlatform.macOS,
  );
}
