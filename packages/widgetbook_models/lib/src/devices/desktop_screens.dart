import 'package:widgetbook_models/src/devices/device.dart';
import 'package:widgetbook_models/src/devices/device_size.dart';
import 'package:widgetbook_models/src/devices/resolution.dart';

/// Collection of all general desktops
class Desktop {
  /// A 720p desktop
  static const Device desktop720p = Device.desktop(
    name: 'Desktop 720p',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1280, height: 720),
      scaleFactor: 2,
    ),
  );

  /// A 1080p desktop
  static const Device desktop1080p = Device.desktop(
    name: 'Desktop 1080p',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 1920, height: 1080),
      scaleFactor: 2,
    ),
  );

  /// A 1440p desktop
  static const Device desktop1440p = Device.desktop(
    name: 'Desktop 1440p',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 2560, height: 1440),
      scaleFactor: 2,
    ),
  );

  /// A 4k desktop
  static const Device desktop4k = Device.desktop(
    name: 'Desktop 4k',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 3840, height: 2160),
      scaleFactor: 2,
    ),
  );

  /// A 8k desktop
  static const Device desktop8k = Device.desktop(
    name: 'Desktop 8k',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 7680, height: 4320),
      scaleFactor: 2,
    ),
  );
}
