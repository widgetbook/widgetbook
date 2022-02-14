// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetbook_device_frame_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetbookDeviceFrameData _$$_WidgetbookDeviceFrameDataFromJson(
        Map<String, dynamic> json) =>
    _$_WidgetbookDeviceFrameData(
      name: json['name'] as String,
      importStatement: json['importStatement'] as String,
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_WidgetbookDeviceFrameDataToJson(
        _$_WidgetbookDeviceFrameData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'importStatement': instance.importStatement,
      'dependencies': instance.dependencies,
    };
