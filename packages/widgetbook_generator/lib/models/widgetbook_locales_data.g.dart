// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetbook_locales_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetbookLocalesData _$$_WidgetbookLocalesDataFromJson(
        Map<String, dynamic> json) =>
    _$_WidgetbookLocalesData(
      name: json['name'] as String,
      importStatement: json['importStatement'] as String,
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_WidgetbookLocalesDataToJson(
        _$_WidgetbookLocalesData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'importStatement': instance.importStatement,
      'dependencies': instance.dependencies,
    };
