import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_size.freezed.dart';

/// Defines the size of a device
///
/// This is implemented since build_runner does not work with flutter
/// dependencies. Therefore, Size from flutter material cannot be used.
@freezed
class DeviceSize with _$DeviceSize {
  /// Creates a new instance of DeviceSize by specifying width and height.
  const factory DeviceSize({
    /// Width of the device
    required double width,

    /// Height of the device
    required double height,
  }) = _DeviceSize;

  const DeviceSize._();

  /// Multiplication operator.
  ///
  /// Returns a [DeviceSize] whose dimensions are the dimensions of the
  /// left-hand-side operand (a [DeviceSize]) multiplied by the scalar
  /// right-hand-side operand (a [double]).
  DeviceSize operator *(double operand) => DeviceSize(
        width: width * operand,
        height: height * operand,
      );

  /// Division operator.
  ///
  /// Returns a [DeviceSize] whose dimensions are the dimensions of the
  /// left-hand-side operand (a [DeviceSize]) divided by the scalar
  /// right-hand-side operand (a [double]).
  DeviceSize operator /(double operand) => DeviceSize(
        width: width / operand,
        height: height / operand,
      );
}
