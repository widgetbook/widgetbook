import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/widgets.dart';

class NoneDevice implements DeviceInfo {
  const NoneDevice._();

  static const NoneDevice instance = NoneDevice._();

  @override
  String get name => 'None';

  @override
  DeviceIdentifier get identifier => throw UnimplementedError();

  @override
  Size get frameSize => throw UnimplementedError();

  @override
  Size get screenSize => throw UnimplementedError();

  @override
  double get pixelRatio => throw UnimplementedError();

  @override
  EdgeInsets? get rotatedSafeAreas => throw UnimplementedError();

  @override
  EdgeInsets get safeAreas => throw UnimplementedError();

  @override
  Path get screenPath => throw UnimplementedError();

  @override
  $DeviceInfoCopyWith<DeviceInfo> get copyWith => throw UnimplementedError();

  @override
  CustomPainter get framePainter => throw UnimplementedError();
}
