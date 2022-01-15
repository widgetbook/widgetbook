import 'package:meta/meta.dart';
import 'package:widgetbook_models/src/devices/device_type.dart';
import 'package:widgetbook_models/src/devices/resolution.dart';

/// A virtual device that will rendered when a story is previewed
@immutable
class Device {
  /// Creates a new device with [name], [resolution], and [type].
  const Device({
    required this.name,
    required this.type,
    this.resolution,
  }) : assert((resolution == null) ^ (type != DeviceType.responsive));

  /// Creates a new watch device
  const Device.watch({
    required this.name,
    required Resolution this.resolution,
  }) : type = DeviceType.watch;

  /// Creates a new mobile device
  const Device.mobile({
    required this.name,
    required Resolution this.resolution,
  }) : type = DeviceType.mobile;

  /// Creates a new tablet device
  const Device.tablet({
    required this.name,
    required Resolution this.resolution,
  }) : type = DeviceType.tablet;

  /// Creates a new desktop device
  const Device.desktop({
    required this.name,
    required Resolution this.resolution,
  }) : type = DeviceType.desktop;

  /// Creates a new special device which does not fit into the other categories
  const Device.special({
    required this.name,
    required Resolution this.resolution,
  }) : type = DeviceType.unknown;

  /// Creates a new responsive web device
  const Device._responsive({
    this.name = 'Responsive',
  })  : type = DeviceType.responsive,
        resolution = null;

  /// Responsive device
  static const Device responsive = Device._responsive();

  /// For example 'iPhone 12' or 'Samsung S10'.
  final String name;

  /// Specifies the native resolution (of the device screen)
  /// and the logical resolution (for rendering a preview on the device).
  /// Set null if use responsive device type
  final Resolution? resolution;

  /// Categorizes the Device.
  /// For instance mobile or tablet.
  /// This is used to display an appropriate icon in the device bar.
  final DeviceType type;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Device &&
        other.name == name &&
        other.resolution == resolution &&
        other.type == type;
  }

  @override
  int get hashCode => name.hashCode ^ resolution.hashCode ^ type.hashCode;
}
