import 'package:flutter/services.dart';

import '../viewport_data.dart';

/// A collection of predefined macOS viewports.
abstract class MacosViewports {
  /// A list of all macOS viewports.
  static const all = [
    desktop,
    macbookPro,
  ];

  /// Represents a viewport for a typical macOS desktop environment.
  static const desktop = ViewportData(
    name: 'macOS Desktop',
    width: 1920,
    height: 1080,
    pixelRatio: 2,
    platform: TargetPlatform.macOS,
  );

  /// Represents a viewport for the MacBook Pro device.
  static const macbookPro = ViewportData(
    name: 'MacBook Pro',
    width: 1800 - 30,
    height: 1000 - 30,
    pixelRatio: 2,
    platform: TargetPlatform.macOS,
  );
}
