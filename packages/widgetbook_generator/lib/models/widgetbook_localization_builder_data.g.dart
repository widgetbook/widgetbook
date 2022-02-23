// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetbook_localization_builder_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetbookLocalizationBuilderData
    _$$_WidgetbookLocalizationBuilderDataFromJson(Map<String, dynamic> json) =>
        _$_WidgetbookLocalizationBuilderData(
          name: json['name'] as String,
          importStatement: json['importStatement'] as String,
          dependencies: (json['dependencies'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
        );

Map<String, dynamic> _$$_WidgetbookLocalizationBuilderDataToJson(
        _$_WidgetbookLocalizationBuilderData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'importStatement': instance.importStatement,
      'dependencies': instance.dependencies,
    };
