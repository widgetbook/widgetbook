import 'package:meta/meta.dart';
import 'package:widgetbook_models/src/devices/device_size.dart';

/// The resolution of a device defined by the nativeSize of the Device
/// and its scaling factor.
@immutable
class Resolution {
  /// Creates a new instance based on nativeSize and scaleFactor
  const Resolution({
    required this.nativeSize,
    required this.scaleFactor,
  });

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

  /// The nativeSize defines the number of pixels of the device screen.
  /// It is used to calculate the logical size of the device by
  /// using the following formula:
  /// logicalSize = nativeSize / scaleFactor
  final DeviceSize nativeSize;

  /// The scaleFactor is used to calculate the logical size of the device by
  /// using the following formula:
  /// logicalSize = nativeSize / scaleFactor
  final double scaleFactor;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Resolution &&
        other.nativeSize == nativeSize &&
        other.scaleFactor == scaleFactor;
  }

  @override
  int get hashCode => nativeSize.hashCode ^ scaleFactor.hashCode;
}
