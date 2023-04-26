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
  Map<String, String> toQueryParameter() {
    return {
      'device': activeDevice?.name ?? 'none',
      'orientation': orientation.name,
      'frame': hasFrame.toString(),
    };
  }

  @override
  DeviceSetting? fromQueryParameter(Map<String, String> queryParameters) {
    return queryParameters.containsKey('device') &&
            queryParameters.containsKey('orientation') &&
            queryParameters.containsKey('frame')
        ? this.copyWith(
            activeDevice: devices.firstWhere(
              (device) => device?.name == queryParameters['device']!,
              orElse: () => null,
            ),
            orientation: Orientation.values.byName(
              queryParameters['orientation']!,
            ),
            hasFrame: queryParameters['frame'] == 'true',
          )
        : null;
  }
}
