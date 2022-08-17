import 'package:freezed_annotation/freezed_annotation.dart';

import '../../locales/models/model.dart';

part 'device_data.freezed.dart';
part 'device_data.g.dart';

@freezed
class DeviceData extends Model with _$DeviceData {
  factory DeviceData({
    required String name,
  }) = _DeviceData;

  factory DeviceData.fromJson(Map<String, dynamic> json) =>
      _$DeviceDataFromJson(json);
}
