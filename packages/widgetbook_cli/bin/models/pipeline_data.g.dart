// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pipeline_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PipelineData _$$_PipelineDataFromJson(Map<String, dynamic> json) =>
    _$_PipelineData(
      actorName: json['actorName'] as String?,
      repository: json['repository'] as String?,
      pipeline: $enumDecode(_$PipelineVendorEnumMap, json['pipeline']),
    );

Map<String, dynamic> _$$_PipelineDataToJson(_$_PipelineData instance) =>
    <String, dynamic>{
      'actorName': instance.actorName,
      'repository': instance.repository,
      'pipeline': _$PipelineVendorEnumMap[instance.pipeline],
    };

const _$PipelineVendorEnumMap = {
  PipelineVendor.isGITHUB: 'isGITHUB',
  PipelineVendor.isGITLAB: 'isGITLAB',
  PipelineVendor.isAZUREPIPELINES: 'isAZUREPIPELINES',
  PipelineVendor.isBITBUCKET: 'isBITBUCKET',
};
