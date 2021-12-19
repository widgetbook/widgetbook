import 'dart:convert';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/extensions/list_extension.dart';
import 'package:widgetbook_generator/generators/app_generator.dart';
import 'package:widgetbook_generator/generators/imports_generator.dart';
import 'package:widgetbook_generator/generators/main_generator.dart';
import 'package:widgetbook_generator/models/widgetbook_story_data.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';
import 'package:widgetbook_generator/readers/device_reader.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

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

    final name = _getName(annotation);
    final devices = _getDevices(annotation);
    final lightTheme =
        themeData.firstWhereOrDefault((element) => !element.isDarkTheme);
    final darkTheme =
        themeData.firstWhereOrDefault((element) => element.isDarkTheme);
    final defaultThemeIsDark = _getDefaultTheme(annotation);

    final buffer = StringBuffer()
      ..writeln(
        generateImports(
          [
            ...themeData,
            ...stories,
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
        ),
      );

    return buffer.toString();
  }
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

Future<List<T>> _loadDataFromJson<T>(
  BuildStep buildStep,
  String extension,
  T Function(Map<String, dynamic>) fromMap,
) async {
  final glob = Glob(extension);
  final widgetbookData = <T>[];
  await for (final id in buildStep.findAssets(glob)) {
    final decodedJson = jsonDecode(await buildStep.readAsString(id)) as List;
    final jsons = decodedJson.cast<Map<String, dynamic>>();
    final something = jsons.map<T>((Map<String, dynamic> json) {
      return fromMap(json);
    }).toList();

    widgetbookData.addAll(something);
  }
  return widgetbookData;
}
