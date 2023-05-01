import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

part 'device_setting.freezed.dart';

@freezed
class DeviceSetting extends WidgetbookAddOnModel<DeviceSetting>
    with _$DeviceSetting {
  factory DeviceSetting({
    required List<Device?> devices,
    required Device? activeDevice,
    @Default(Orientation.portrait) Orientation orientation,
    @Default(true) bool hasFrame,
  }) = _DeviceSetting;

  DeviceSetting._();

  @override
  Map<String, String> toMap() {
    return {
      'device': activeDevice?.name ?? 'none',
      'orientation': orientation.name,
      'frame': hasFrame.toString(),
    };
  }

  @override
  DeviceSetting fromMap(Map<String, String> map) {
    return this.copyWith(
      activeDevice: devices.firstWhere(
        (device) => device?.name == map['device'],
        orElse: () => null,
      ),
      orientation: Orientation.values.byName(
        map['orientation'] ?? Orientation.portrait.name,
      ),
      hasFrame: map['frame'] == 'true',
    );
  }
}
