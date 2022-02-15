// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetbook_use_case_builder_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetbookUseCaseBuilderData _$$_WidgetbookUseCaseBuilderDataFromJson(
        Map<String, dynamic> json) =>
    _$_WidgetbookUseCaseBuilderData(
      name: json['name'] as String,
      importStatement: json['importStatement'] as String,
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_WidgetbookUseCaseBuilderDataToJson(
        _$_WidgetbookUseCaseBuilderData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'importStatement': instance.importStatement,
      'dependencies': instance.dependencies,
    };
