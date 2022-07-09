// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetbook_theme_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetbookThemeData _$$_WidgetbookThemeDataFromJson(
        Map<String, dynamic> json) =>
    _$_WidgetbookThemeData(
      name: json['name'] as String,
      importStatement: json['importStatement'] as String,
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isDefault: json['isDefault'] as bool,
      themeName: json['themeName'] as String,
    );

Map<String, dynamic> _$$_WidgetbookThemeDataToJson(
        _$_WidgetbookThemeData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'importStatement': instance.importStatement,
      'dependencies': instance.dependencies,
      'isDefault': instance.isDefault,
      'themeName': instance.themeName,
    };
