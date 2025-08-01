import 'package:flutter/foundation.dart';

import '../viewport_data.dart';

/// A collection of predefined Windows viewports.
abstract class WindowsViewports {
  /// A list of all Windows viewports.
  static const all = [desktop];

  /// Represents a viewport for a typical Windows desktop environment.
  static const desktop = ViewportData(
    name: 'Windows Desktop',
    width: 1920,
    height: 1080,
    pixelRatio: 2,
    platform: TargetPlatform.windows,
  );
}
