import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/extensions/list_extension.dart';
import 'package:widgetbook_generator/generators/app_generator.dart';
import 'package:widgetbook_generator/generators/imports_generator.dart';
import 'package:widgetbook_generator/generators/main_generator.dart';
import 'package:widgetbook_generator/models/widgetbook_locales_data.dart';
import 'package:widgetbook_generator/models/widgetbook_story_data.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';
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
    // Verification that only one light and one dark theme exist
    final themeData = await _loadDataFromJson<WidgetbookThemeData>(
      buildStep,
      '**.theme.widgetbook.json',
      (map) => WidgetbookThemeData.fromMap(map),
    );

    final stories = await _loadDataFromJson<WidgetbookStoryData>(
      buildStep,
      '**.story.widgetbook.json',
      (map) => WidgetbookStoryData.fromMap(map),
    );

    final locales = await _getLocales(buildStep);

    final name = _getName(annotation);
    final devices = _getDevices(annotation);
    final lightTheme =
        themeData.firstWhereOrDefault((element) => !element.isDarkTheme);
    final darkTheme =
        themeData.firstWhereOrDefault((element) => element.isDarkTheme);
    final defaultThemeIsDark = _getDefaultTheme(annotation);
    final foldersExpanded = _getFoldersExpanded(annotation);
    final widgetsExpanded = _getWidgetsExpanded(annotation);

    final buffer = StringBuffer()
      ..writeln(
        generateImports(
          [
            ...themeData,
            ...stories,
            if (locales != null) locales,
          ],
        ),
      )
      ..writeln(
        generateMain(),
      )
      ..writeln(
        generateWidgetbook(
          name: name,
          lightTheme: lightTheme,
          darkTheme: darkTheme,
          defaultThemeIsDark: defaultThemeIsDark,
          stories: stories,
          devices: devices,
          foldersExpanded: foldersExpanded,
          widgetsExpanded: widgetsExpanded,
          localesData: locales,
        ),
      );

    return buffer.toString();
  }
}

Future<WidgetbookLocalesData?> _getLocales(BuildStep buildStep) async {
  final locales = await _loadDataFromJson(
    buildStep,
    '**.locales.widgetbook.json',
    (map) => WidgetbookLocalesData.fromJson(map),
  );

  if (locales.length > 1) {
    throw InvalidGenerationSourceError(
      'More than one list of locales defined.',
    );
  }

  return locales.isNotEmpty ? locales.first : null;
}

List<Device> _getDevices(ConstantReader annotation) {
  final devices = <Device>[];

  for (final deviceObject in annotation.read('devices').listValue) {
    final device = DeviceReader().read(deviceObject);
    devices.add(device);
  }

  return devices;
}

String _getName(ConstantReader annotation) {
  return annotation.read('name').stringValue;
}

bool? _getDefaultTheme(ConstantReader annotation) {
  final defaultTheme = annotation.read('defaultTheme');
  return defaultTheme.isNull
      ? null
      : defaultTheme.objectValue.getField('isDarkTheme')?.toBoolValue();
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
    dynamic content = jsonDecode(await buildStep.readAsString(id));
    final decodedJson = content as List;
    final jsons = decodedJson.cast<Map<String, dynamic>>();
    final something = jsons.map<T>((Map<String, dynamic> json) {
      return fromMap(json);
    }).toList();

    widgetbookData.addAll(something);
  }
  return widgetbookData;
}
