import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/addons/device_addon/frames/frames.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

part 'device_setting.freezed.dart';

@freezed
class DeviceSetting extends WidgetbookAddOnModel with _$DeviceSetting {
  @Assert('devices.isNotEmpty', 'devices cannot be empty')
  factory DeviceSetting({
    required List<Device?> devices,
    required Device? activeDevice,
    @Default(Orientation.portrait) Orientation orientation,
    @Default(true) bool hasFrame,
  }) = _DeviceSetting;

  /// Sets the first [Device] within [devices] as the [activeDevice] on startup
  factory DeviceSetting.firstAsSelected({
    required List<Device?> devices,
  }) {
    return DeviceSetting(
      devices: devices,
      activeDevice: devices.first,
    );
  }

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
  fromQueryParameter(Map<String, String> queryParameters) {
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
            hasFrame: queryParameters['orientation'] == 'true',
          )
        : null;
  }

  FrameBuilder get frameBuilder {
    if (activeDevice == null) {
      return NoFrameBuilder(
        setting: this,
      );
    }

    if (!hasFrame) {
      return WidgetbookFrame(
        setting: this,
      );
    }

    return DeviceFrameBuilder(
      setting: this,
    );
  }
}
