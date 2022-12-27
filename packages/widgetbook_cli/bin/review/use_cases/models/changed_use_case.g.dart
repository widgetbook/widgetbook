// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changed_use_case.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChangedUseCase _$$_ChangedUseCaseFromJson(Map<String, dynamic> json) =>
    _$_ChangedUseCase(
      name: json['name'] as String,
      componentName: json['componentName'] as String,
      componentDefinitionPath: json['componentDefinitionPath'] as String,
      modification: $enumDecode(_$ModificationEnumMap, json['modification']),
      designLink: json['designLink'] as String?,
    );

Map<String, dynamic> _$$_ChangedUseCaseToJson(_$_ChangedUseCase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'componentName': instance.componentName,
      'componentDefinitionPath': instance.componentDefinitionPath,
      'modification': _$ModificationEnumMap[instance.modification],
      'designLink': instance.designLink,
    };

const _$ModificationEnumMap = {
  Modification.removed: 'removed',
  Modification.changed: 'changed',
  Modification.added: 'added',
};
