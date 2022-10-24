// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Package _$$_PackageFromJson(Map<String, dynamic> json) => _$_Package(
      name: json['name'] as String,
      path: json['path'] as String,
      type: $enumDecode(_$PackageTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$_PackageToJson(_$_Package instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'type': _$PackageTypeEnumMap[instance.type],
    };

const _$PackageTypeEnumMap = {
  PackageType.dartPackage: 'dartPackage',
  PackageType.flutterPackage: 'flutterPackage',
};
