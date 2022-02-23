import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

part 'widgetbook_device_frame_data.freezed.dart';
part 'widgetbook_device_frame_data.g.dart';

@freezed
class WidgetbookDeviceFrameData extends WidgetbookData
    with _$WidgetbookDeviceFrameData {
  factory WidgetbookDeviceFrameData({
    required String name,
    required String importStatement,
    required List<String> dependencies,
  }) = _WidgetbookDeviceFrameData;

  factory WidgetbookDeviceFrameData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookDeviceFrameDataFromJson(json);
}
