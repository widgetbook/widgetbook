import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/widgetbook.dart';

part 'device_setting.freezed.dart';

@freezed
class DeviceSetting with _$DeviceSetting {
  factory DeviceSetting({
    required List<Device> devices,
    required Device activeDevice,
    @Default(Orientation.portrait) Orientation orientation,
  }) = _DeviceSetting;

  factory DeviceSetting.firstAsSelected({
    required List<Device> devices,
  }) {
    assert(
      devices.isNotEmpty,
      'Please specify at least one $Device',
    );
    return DeviceSetting(
      activeDevice: devices.first,
      devices: devices,
    );
  }
}
