import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_frame.freezed.dart';

// TODO rename this to WidgetbookFrame
@freezed
class DeviceFrame with _$DeviceFrame {
  const factory DeviceFrame({
    /// The name displayed as a tooltip
    required String name,

    /// Indicators whether this mode supports specific devices e.g. iPhone 11
    required bool allowsDevices,
  }) = _DeviceFrame;

  // TODO rename this to `default`
  factory DeviceFrame.widgetbook() {
    return const DeviceFrame(
      name: 'Widgetbook',
      allowsDevices: true,
    );
  }

  factory DeviceFrame.none() {
    return const DeviceFrame(
      name: 'None',
      allowsDevices: false,
    );
  }

  factory DeviceFrame.deviceFrame() {
    return const DeviceFrame(
      name: 'Device Preview',
      allowsDevices: true,
    );
  }
}
