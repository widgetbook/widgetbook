/// Defines the size of a device
///
/// This is implemented since build_runner does not work with flutter
/// dependencies. Therefore, Size from flutter material cannot be used.
class DeviceSize {
  /// Creates a new instance of DeviceSize by specifying width and height.
  const DeviceSize({
    required this.width,
    required this.height,
  });

  /// Width of the device
  final double width;

  /// Height of the device
  final double height;

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeviceSize &&
        other.width == width &&
        other.height == height;
  }

  @override
  int get hashCode => width.hashCode ^ height.hashCode;
}
