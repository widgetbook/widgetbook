import 'package:freezed_annotation/freezed_annotation.dart';

part 'widgetbook_device_data.freezed.dart';
part 'widgetbook_device_data.g.dart';

@freezed
class WidgetbookDeviceData with _$WidgetbookDeviceData {
  factory WidgetbookDeviceData({
    required String name,
  }) = _WidgetbookDeviceData;

  factory WidgetbookDeviceData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookDeviceDataFromJson(json);
}
