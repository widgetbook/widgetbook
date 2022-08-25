import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/addons/device_addon/frame_builders/frame_builder.dart';
import 'package:widgetbook/widgetbook.dart';

part 'device_selection.freezed.dart';

@freezed
class DeviceSelection with _$DeviceSelection {
  factory DeviceSelection({
    required FrameBuilder activeFrameBuilder,
    @Default(<Device>{}) Set<Device> activeDevices,
    required List<FrameBuilder> frameBuilders,
  }) = _DeviceSelection;
}
