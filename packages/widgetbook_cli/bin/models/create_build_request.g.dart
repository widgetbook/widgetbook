// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_build_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CreateBuildRequest _$$_CreateBuildRequestFromJson(
        Map<String, dynamic> json) =>
    _$_CreateBuildRequest(
      apiKey: json['apiKey'] as String,
      branchName: json['branchName'] as String,
      repositoryName: json['repositoryName'] as String,
      commitSha: json['commitSha'] as String,
      actor: json['actor'] as String,
      provider: json['provider'] as String,
      themes: (json['themes'] as List<dynamic>)
          .map((e) => ThemeData.fromJson(e as Map<String, dynamic>))
          .toList(),
      locales: (json['locales'] as List<dynamic>)
          .map((e) => LocaleData.fromJson(e as Map<String, dynamic>))
          .toList(),
      devices: (json['devices'] as List<dynamic>)
          .map((e) => DeviceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      textScaleFactors: (json['textScaleFactors'] as List<dynamic>)
          .map((e) => TextScaleFactorData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CreateBuildRequestToJson(
        _$_CreateBuildRequest instance) =>
    <String, dynamic>{
      'apiKey': instance.apiKey,
      'branchName': instance.branchName,
      'repositoryName': instance.repositoryName,
      'commitSha': instance.commitSha,
      'actor': instance.actor,
      'provider': instance.provider,
      'themes': instance.themes,
      'locales': instance.locales,
      'devices': instance.devices,
      'textScaleFactors': instance.textScaleFactors,
    };
