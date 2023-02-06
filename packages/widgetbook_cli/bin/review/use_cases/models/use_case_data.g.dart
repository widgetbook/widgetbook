// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'use_case_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UseCaseData _$$_UseCaseDataFromJson(Map<String, dynamic> json) =>
    _$_UseCaseData(
      name: json['name'] as String,
      useCaseName: json['useCaseName'] as String,
      componentName: json['componentName'] as String,
      importStatement: json['importStatement'] as String,
      componentImportStatement: json['componentImportStatement'] as String,
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      componentDefinitionPath: json['componentDefinitionPath'] as String,
      useCaseDefinitionPath: json['useCaseDefinitionPath'] as String,
      designLink: json['designLink'] as String?,
    );

Map<String, dynamic> _$$_UseCaseDataToJson(_$_UseCaseData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'useCaseName': instance.useCaseName,
      'componentName': instance.componentName,
      'importStatement': instance.importStatement,
      'componentImportStatement': instance.componentImportStatement,
      'dependencies': instance.dependencies,
      'componentDefinitionPath': instance.componentDefinitionPath,
      'useCaseDefinitionPath': instance.useCaseDefinitionPath,
      'designLink': instance.designLink,
    };
