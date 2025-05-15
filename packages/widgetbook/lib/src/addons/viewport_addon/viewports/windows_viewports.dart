import 'package:flutter/foundation.dart';

import '../viewport_data.dart';

abstract class WindowsViewports {
  static const all = [desktop];

  static const desktop = ViewportData(
    name: 'Windows Desktop',
    width: 1920,
    height: 1080,
    pixelRatio: 2,
    platform: TargetPlatform.windows,
  );
}
