// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetbook_scaffold_builder_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetbookScaffoldBuilderData _$$_WidgetbookScaffoldBuilderDataFromJson(
        Map<String, dynamic> json) =>
    _$_WidgetbookScaffoldBuilderData(
      name: json['name'] as String,
      importStatement: json['importStatement'] as String,
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_WidgetbookScaffoldBuilderDataToJson(
        _$_WidgetbookScaffoldBuilderData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'importStatement': instance.importStatement,
      'dependencies': instance.dependencies,
    };
