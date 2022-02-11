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
    final stories = await _loadDataFromJson<WidgetbookStoryData>(
      buildStep,
      '**.story.widgetbook.json',
      (map) => WidgetbookStoryData.fromMap(map),
    );

    final locales = await _getLocales(buildStep);

    final name = _getName(annotation);
    final devices = _getDevices(annotation);
    final frames = _getFrames(annotation);
    final textScaleFactors = _getTextScaleFactors(annotation);
    final themes = await _getThemes(buildStep);
    final foldersExpanded = _getFoldersExpanded(annotation);
    final widgetsExpanded = _getWidgetsExpanded(annotation);

    final buffer = StringBuffer()
      ..writeln(
        generateImports(
          [
            ...themes,
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
          themes: themes,
          stories: stories,
          devices: devices,
          frames: frames,
          textScaleFactors: textScaleFactors,
          foldersExpanded: foldersExpanded,
          widgetsExpanded: widgetsExpanded,
          localesData: locales,
        ),
      );

    return buffer.toString();
  }
}

Future<List<WidgetbookThemeData>> _getThemes(BuildStep buildStep) async {
  final themes = await _loadDataFromJson<WidgetbookThemeData>(
    buildStep,
    '**.theme.widgetbook.json',
    (map) => WidgetbookThemeData.fromJson(map),
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

List<WidgetbookFrame> _getFrames(ConstantReader annotation) {
  final frames = <WidgetbookFrame>[];

  for (final deviceObject in annotation.read('frames').listValue) {
    final name = deviceObject.getField('name')!.toStringValue()!;
    final allowsDevices =
        deviceObject.getField('allowsDevices')!.toBoolValue()!;

    frames.add(WidgetbookFrame(name: name, allowsDevices: allowsDevices));
  }

  return frames;
}

List<double> _getTextScaleFactors(ConstantReader annotation) {
  final factors = <double>[];

  for (final value in annotation.read('textScaleFactors').listValue) {
    factors.add(value.toDoubleValue()!);
  }

  return factors;
}

String _getName(ConstantReader annotation) {
  return annotation.read('name').stringValue;
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
