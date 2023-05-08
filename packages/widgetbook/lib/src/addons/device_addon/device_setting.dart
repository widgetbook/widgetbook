import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/widgetbook.dart';

part 'device_setting.freezed.dart';

@freezed
class DeviceSetting with _$DeviceSetting {
  factory DeviceSetting({
    required List<DeviceInfo?> devices,
    required DeviceInfo? activeDevice,
    @Default(Orientation.portrait) Orientation orientation,
    @Default(true) bool hasFrame,
  }) = _DeviceSetting;

  DeviceSetting._();
}
