import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_models/src/devices/device_type.dart';
import 'package:widgetbook_models/src/devices/resolution.dart';

part 'device.freezed.dart';

/// A virtual device that will rendered when a story is previewed
@freezed
class Device with _$Device {
  /// Creates a new device with [name], [resolution], and [type].
  const factory Device({
    /// For example 'iPhone 12' or 'Samsung S10'.
    required String name,

    /// Specifies the native resolution (of the device screen)
    /// and the logical resolution (for rendering a preview on the device).
    required Resolution resolution,

    /// Categorizes the Device.
    /// For instance mobile or tablet.
    /// This is used to display an appropriate icon in the device bar.
    required DeviceType type,
  }) = _Device;

  const Device._();

  /// Creates a new watch device
  const factory Device.watch({
    required String name,
    required Resolution resolution,
    @Default(DeviceType.watch) DeviceType type,
  }) = _DeviceWatch;

  /// Creates a new mobile device
  const factory Device.mobile({
    required String name,
    required Resolution resolution,
    @Default(DeviceType.mobile) DeviceType type,
  }) = _DeviceMobile;

  /// Creates a new tablet device
  const factory Device.tablet({
    required String name,
    required Resolution resolution,
    @Default(DeviceType.tablet) DeviceType type,
  }) = _DeviceTablet;

  /// Creates a new desktop device
  const factory Device.desktop({
    required String name,
    required Resolution resolution,
    @Default(DeviceType.desktop) DeviceType type,
  }) = _DeviceDesktop;

  /// Creates a new special device which does not fit into the other categories
  const factory Device.special({
    required String name,
    required Resolution resolution,
    @Default(DeviceType.unknown) DeviceType type,
  }) = _DeviceSpecial;
}
