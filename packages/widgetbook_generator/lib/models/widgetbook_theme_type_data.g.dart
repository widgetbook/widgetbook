// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetbook_theme_type_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetbookThemeTypeData _$$_WidgetbookThemeTypeDataFromJson(
        Map<String, dynamic> json) =>
    _$_WidgetbookThemeTypeData(
      name: json['name'] as String,
      importStatement: json['importStatement'] as String,
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_WidgetbookThemeTypeDataToJson(
        _$_WidgetbookThemeTypeData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'importStatement': instance.importStatement,
      'dependencies': instance.dependencies,
    };
