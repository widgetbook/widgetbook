import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/extensions/element_extensions.dart';
import 'package:widgetbook_generator/extensions/list_extension.dart';
import 'package:widgetbook_generator/generators/app_generator.dart';
import 'package:widgetbook_generator/generators/imports_generator.dart';
import 'package:widgetbook_generator/generators/main_generator.dart';
import 'package:widgetbook_generator/models/widgetbook_app_builder_data.dart';
import 'package:widgetbook_generator/models/widgetbook_locales_data.dart';
import 'package:widgetbook_generator/models/widgetbook_localizations_delegates_data.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_type_data.dart';
import 'package:widgetbook_generator/models/widgetbook_use_case_data.dart';
import 'package:widgetbook_generator/readers/device_reader.dart';

/// Generates the code for Widgetbook
///
/// The code is located at the same location in which the [WidgetbookApp]
/// annotation is used.
class WidgetbookGenerator extends GeneratorForAnnotation<WidgetbookApp> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final useCases = await _loadDataFromJson<WidgetbookUseCaseData>(
      buildStep,
      '**.usecase.widgetbook.json',
      WidgetbookUseCaseData.fromJson,
    );

    final appBuilder = await _loadDataFromJson<WidgetbookAppBuilderData>(
      buildStep,
      '**.appbuilder.widgetbook.json',
      WidgetbookAppBuilderData.fromJson,
    );

    final locales = await _getLocales(buildStep);
    final localizationDelegates = await _getLocalizationDelegates(buildStep);

    final themeType = _getThemeType(annotation);
    final devices = _getDevices(annotation);
    final textScaleFactors = _getTextScaleFactors(annotation);
    final themes = await _getThemes(buildStep);
    final foldersExpanded = _getFoldersExpanded(annotation);
    final widgetsExpanded = _getWidgetsExpanded(annotation);
    final constructor = _getConstructor(annotation);

    final buffer = StringBuffer()
      ..writeln(
        generateImports(
          [
            ...themes,
            ...useCases,
            if (locales != null) locales,
          ],
        ),
      )
      ..writeln(
        generateMain(),
      )
      ..writeln(
        generateWidgetbook(
          constructor: constructor,
          themeTypeData: themeType,
          themes: themes,
          useCases: useCases,
          devices: devices,
          textScaleFactors: textScaleFactors,
          foldersExpanded: foldersExpanded,
          widgetsExpanded: widgetsExpanded,
          localesData: locales,
          localizationDelegatesData: localizationDelegates,
          appBuilder: appBuilder.isNotEmpty ? appBuilder.first : null,
        ),
      );

    return buffer.toString();
  }
}

Future<List<WidgetbookThemeData>> _getThemes(BuildStep buildStep) async {
  final themes = await _loadDataFromJson<WidgetbookThemeData>(
    buildStep,
    '**.theme.widgetbook.json',
    WidgetbookThemeData.fromJson,
  );

  final defaultTheme =
      themes.firstWhereOrDefault((element) => element.isDefault);
  if (defaultTheme != null) {
    themes
      ..remove(defaultTheme)
      ..insert(0, defaultTheme);
  }

  return themes;
}

Future<WidgetbookLocalesData?> _getLocales(BuildStep buildStep) async {
  final locales = await _loadDataFromJson(
    buildStep,
    '**.locales.widgetbook.json',
    WidgetbookLocalesData.fromJson,
  );

  if (locales.length > 1) {
    throw InvalidGenerationSourceError(
      'More than one list of locales defined.',
    );
  }

  return locales.isNotEmpty ? locales.first : null;
}

Future<WidgetbookLocalizationsDelegatesData?> _getLocalizationDelegates(
  BuildStep buildStep,
) async {
  final localizationDelegates = await _loadDataFromJson(
    buildStep,
    '**.delegates.widgetbook.json',
    WidgetbookLocalizationsDelegatesData.fromJson,
  );

  if (localizationDelegates.length > 1) {
    throw InvalidGenerationSourceError(
      'More than one list of delegates defined.',
    );
  }

  return localizationDelegates.isNotEmpty ? localizationDelegates.first : null;
}

List<Device> _getDevices(ConstantReader annotation) {
  final devices = <Device>[];

  for (final deviceObject in annotation.read('devices').listValue) {
    final device = DeviceReader().read(deviceObject);
    devices.add(device);
  }

  return devices;
}

List<double> _getTextScaleFactors(ConstantReader annotation) {
  final factors = <double>[];

  for (final value in annotation.read('textScaleFactors').listValue) {
    factors.add(value.toDoubleValue()!);
  }

  return factors;
}

WidgetbookConstructor _getConstructor(ConstantReader annotation) {
  final index = annotation.read('constructor').read('index').intValue;
  return WidgetbookConstructor.values[index];
}

WidgetbookThemeTypeData? _getThemeType(ConstantReader annotation) {
  final type = annotation.read('themeType');
  if (!type.isNull) {
    final typeValue = type.typeValue;
    final element = typeValue.element;
    return WidgetbookThemeTypeData(
      name: typeValue.getDisplayString(withNullability: false),
      importStatement: element!.importStatement,
      dependencies: element.dependencies,
    );
  }
  return null;
}

bool _getFoldersExpanded(ConstantReader annotation) {
  return annotation.read('foldersExpanded').boolValue;
}

bool _getWidgetsExpanded(ConstantReader annotation) {
  return annotation.read('widgetsExpanded').boolValue;
}

Future<List<T>> _loadDataFromJson<T>(
  BuildStep buildStep,
  String extension,
  T Function(Map<String, dynamic>) fromMap,
) async {
  final glob = Glob(extension);
  final widgetbookData = <T>[];
  await for (final id in buildStep.findAssets(glob)) {
    final dynamic content = jsonDecode(await buildStep.readAsString(id));
    final decodedJson = content as List;
    final jsons = decodedJson.cast<Map<String, dynamic>>();
    final something = jsons.map<T>((Map<String, dynamic> json) {
      return fromMap(json);
    }).toList();

    widgetbookData.addAll(something);
  }
  return widgetbookData;
}
