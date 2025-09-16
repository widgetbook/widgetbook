import 'package:flutter/foundation.dart';

import '../viewport_data.dart';

/// A collection of predefined Linux viewports.
abstract class LinuxViewports {
  /// A list of all Linux viewports.
  static const all = [desktop];

  /// Represents a viewport for a typical Linux desktop environment.
  static const desktop = ViewportData(
    name: 'Linux Desktop',
    width: 1920,
    height: 1080,
    pixelRatio: 2,
    platform: TargetPlatform.linux,
  );
}
