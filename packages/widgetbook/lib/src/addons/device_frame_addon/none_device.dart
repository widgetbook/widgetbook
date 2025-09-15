import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
// ignore: unnecessary_import flutter(<3.35)
import 'package:meta/meta.dart';

@internal
class NoneDevice with DiagnosticableTreeMixin implements DeviceInfo {
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
  CustomPainter get framePainter => throw UnimplementedError();

  @override
  DeviceInfo copyWith({
    DeviceIdentifier? identifier,
    String? name,
    EdgeInsets? rotatedSafeAreas,
    EdgeInsets? safeAreas,
    Path? screenPath,
    double? pixelRatio,
    CustomPainter? framePainter,
    Size? frameSize,
    Size? screenSize,
  }) {
    return instance;
  }
}
