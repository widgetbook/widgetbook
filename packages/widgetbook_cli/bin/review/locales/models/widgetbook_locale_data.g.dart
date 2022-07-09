// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetbook_locale_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetbookLocaleData _$$_WidgetbookLocaleDataFromJson(
        Map<String, dynamic> json) =>
    _$_WidgetbookLocaleData(
      name: json['name'] as String,
      importStatement: json['importStatement'] as String,
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      locales:
          (json['locales'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_WidgetbookLocaleDataToJson(
        _$_WidgetbookLocaleData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'importStatement': instance.importStatement,
      'dependencies': instance.dependencies,
      'locales': instance.locales,
    };
