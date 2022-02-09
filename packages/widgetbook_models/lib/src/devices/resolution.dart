import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_models/src/devices/device_size.dart';

part 'resolution.freezed.dart';

/// The resolution of a device defined by the nativeSize of the Device
/// and its scaling factor.
@freezed
class Resolution with _$Resolution {
  /// Creates a new instance based on nativeSize and scaleFactor
  const factory Resolution({
    /// The nativeSize defines the number of pixels of the device screen.
    /// It is used to calculate the logical size of the device by
    /// using the following formula:
    /// logicalSize = nativeSize / scaleFactor
    required DeviceSize nativeSize,

    /// The scaleFactor is used to calculate the logical size of the device by
    /// using the following formula:
    /// logicalSize = nativeSize / scaleFactor
    required double scaleFactor,
  }) = _Resolution;

  const Resolution._();

  /// Crates a newinstance based on nativeWidth, nativeHeight and scaleFactor
  factory Resolution.dimensions({
    required double nativeWidth,
    required double nativeHeight,
    required double scaleFactor,
  }) {
    return Resolution(
      nativeSize: DeviceSize(
        width: nativeWidth,
        height: nativeHeight,
      ),
      scaleFactor: scaleFactor,
    );
  }

  /// The logicalSize defines the number of pixels in the render engine.
  /// It is calculated by using the following formula:
  /// logicalSize = nativeSize / scaleFactor
  DeviceSize get logicalSize => nativeSize / scaleFactor;
}
