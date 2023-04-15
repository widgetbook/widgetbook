import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

part 'device_setting.freezed.dart';

@freezed
class DeviceSetting extends WidgetbookAddOnModel<DeviceSetting>
    with _$DeviceSetting {
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

  const DeviceSetting._();

  @override
  Map<String, String> toQueryParameter() {
    return {
      'orientation': orientation.name,
      'device': activeDevice.name,
    };
  }

  @override
  DeviceSetting? fromQueryParameter(Map<String, String> queryParameters) {
    return this.copyWith(
      orientation: Orientation.values.byName(
        queryParameters['orientation'] ?? orientation.name,
      ),
      activeDevice: devices.firstWhere(
        (device) => device.name == queryParameters['device'],
        orElse: () => activeDevice,
      ),
    );
  }
}
