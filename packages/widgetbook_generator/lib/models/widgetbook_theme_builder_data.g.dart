// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetbook_theme_builder_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetbookThemeBuilderData _$$_WidgetbookThemeBuilderDataFromJson(
        Map<String, dynamic> json) =>
    _$_WidgetbookThemeBuilderData(
      name: json['name'] as String,
      importStatement: json['importStatement'] as String,
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_WidgetbookThemeBuilderDataToJson(
        _$_WidgetbookThemeBuilderData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'importStatement': instance.importStatement,
      'dependencies': instance.dependencies,
    };
