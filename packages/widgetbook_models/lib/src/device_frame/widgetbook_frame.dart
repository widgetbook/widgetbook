import 'package:freezed_annotation/freezed_annotation.dart';

part 'widgetbook_frame.freezed.dart';

/// Declares a frame for a phone displaying its characteristics.
@freezed
class WidgetbookFrame with _$WidgetbookFrame {
  /// Creates a new instance of [WidgetbookFrame].
  const factory WidgetbookFrame({
    /// The name displayed as a tooltip
    required String name,

    /// Indicators whether this mode supports specific devices e.g. iPhone 11
    required bool allowsDevices,
  }) = _WidgetbookFrame;

  /// The default Widgetbook frame
  /// This is a container with a small border
  factory WidgetbookFrame.defaultFrame() {
    return const WidgetbookFrame(
      name: 'Widgetbook',
      allowsDevices: true,
    );
  }

  /// No frame
  /// This can be used to display widgets in isolation, e.g. for Buttons or
  /// smaller UI components
  factory WidgetbookFrame.noFrame() {
    return const WidgetbookFrame(
      name: 'None',
      allowsDevices: false,
    );
  }

  /// A frame based on the `device_frame` package:
  /// https://pub.dev/packages/device_frame
  factory WidgetbookFrame.deviceFrame() {
    return const WidgetbookFrame(
      name: 'Device Frame',
      allowsDevices: true,
    );
  }
}
