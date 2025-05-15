import 'package:flutter/foundation.dart';

import '../viewport_data.dart';

abstract class LinuxViewports {
  static const all = [desktop];

  static const desktop = ViewportData(
    name: 'Linux Desktop',
    width: 1920,
    height: 1080,
    pixelRatio: 2,
    platform: TargetPlatform.linux,
  );
}
