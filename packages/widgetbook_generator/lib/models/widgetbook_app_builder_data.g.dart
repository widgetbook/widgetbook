// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetbook_app_builder_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetbookAppBuilderData _$$_WidgetbookAppBuilderDataFromJson(
        Map<String, dynamic> json) =>
    _$_WidgetbookAppBuilderData(
      name: json['name'] as String,
      importStatement: json['importStatement'] as String,
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_WidgetbookAppBuilderDataToJson(
        _$_WidgetbookAppBuilderData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'importStatement': instance.importStatement,
      'dependencies': instance.dependencies,
    };
