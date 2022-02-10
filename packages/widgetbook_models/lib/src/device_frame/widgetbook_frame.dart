import 'package:freezed_annotation/freezed_annotation.dart';

part 'widgetbook_frame.freezed.dart';

@freezed
class WidgetbookFrame with _$WidgetbookFrame {
  const factory WidgetbookFrame({
    /// The name displayed as a tooltip
    required String name,

    /// Indicators whether this mode supports specific devices e.g. iPhone 11
    required bool allowsDevices,
  }) = _WidgetbookFrame;

  factory WidgetbookFrame.defaultFrame() {
    return const WidgetbookFrame(
      name: 'Widgetbook',
      allowsDevices: true,
    );
  }

  factory WidgetbookFrame.noFrame() {
    return const WidgetbookFrame(
      name: 'None',
      allowsDevices: false,
    );
  }

  factory WidgetbookFrame.deviceFrame() {
    return const WidgetbookFrame(
      name: 'Device Frame',
      allowsDevices: true,
    );
  }
}
