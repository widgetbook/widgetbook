import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../viewport_data.dart';
import 'android_viewports.dart';
import 'ios_viewports.dart';
import 'linux_viewports.dart';
import 'macos_viewports.dart';
import 'windows_viewports.dart';

/// A special [ViewportData] that represents no viewport.
/// Null is not used for simplicity reasons.
@internal
class NoneViewport extends ViewportData {
  const NoneViewport()
      : super(
          name: 'None',
          width: 0,
          height: 0,
          pixelRatio: 0,
          platform: TargetPlatform.fuchsia,
        );
}

abstract class Viewports {
  static const none = NoneViewport();

  static const all = [
    none,
    ...IosViewports.all,
    ...AndroidViewports.all,
    ...MacosViewports.all,
    ...WindowsViewports.all,
    ...LinuxViewports.all,
  ];
}
