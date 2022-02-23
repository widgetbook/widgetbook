// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetbook_localizations_delegates_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetbookLocalizationsDelegatesData
    _$$_WidgetbookLocalizationsDelegatesDataFromJson(
            Map<String, dynamic> json) =>
        _$_WidgetbookLocalizationsDelegatesData(
          name: json['name'] as String,
          importStatement: json['importStatement'] as String,
          dependencies: (json['dependencies'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
        );

Map<String, dynamic> _$$_WidgetbookLocalizationsDelegatesDataToJson(
        _$_WidgetbookLocalizationsDelegatesData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'importStatement': instance.importStatement,
      'dependencies': instance.dependencies,
    };
