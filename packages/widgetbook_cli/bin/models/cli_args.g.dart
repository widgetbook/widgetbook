// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cli_args.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CliArgs _$$_CliArgsFromJson(Map<String, dynamic> json) => _$_CliArgs(
      apiKey: json['apiKey'] as String,
      branch: json['branch'] as String,
      commit: json['commit'] as String,
      gitProvider: json['gitProvider'] as String,
      gitHubToken: json['gitHubToken'] as String?,
      prNumber: json['prNumber'] as String?,
      baseBranch: json['baseBranch'] as String?,
      path: json['path'] as String,
    );

Map<String, dynamic> _$$_CliArgsToJson(_$_CliArgs instance) =>
    <String, dynamic>{
      'apiKey': instance.apiKey,
      'branch': instance.branch,
      'commit': instance.commit,
      'gitProvider': instance.gitProvider,
      'gitHubToken': instance.gitHubToken,
      'prNumber': instance.prNumber,
      'baseBranch': instance.baseBranch,
      'path': instance.path,
    };
