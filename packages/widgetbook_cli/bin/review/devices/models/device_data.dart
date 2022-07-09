import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_data.freezed.dart';
part 'device_data.g.dart';

@freezed
class DeviceData with _$DeviceData {
  factory DeviceData({
    required String name,
  }) = _DeviceData;

  factory DeviceData.fromJson(Map<String, dynamic> json) =>
      _$DeviceDataFromJson(json);
}
