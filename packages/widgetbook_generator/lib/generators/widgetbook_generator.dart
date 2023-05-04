import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/generators/app_generator.dart';
import 'package:widgetbook_generator/generators/imports_generator.dart';
import 'package:widgetbook_generator/generators/main_generator.dart';
import 'package:widgetbook_generator/models/widgetbook_app_builder_data.dart';
import 'package:widgetbook_generator/models/widgetbook_use_case_data.dart';

/// Generates the code for Widgetbook
///
/// The code is located at the same location in which the [App]
/// annotation is used.
class WidgetbookGenerator extends GeneratorForAnnotation<App> {
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

    final foldersExpanded = _getFoldersExpanded(annotation);
    final widgetsExpanded = _getWidgetsExpanded(annotation);
    final constructor = _getConstructor(annotation);

    final buffer = StringBuffer()
      ..writeln(
        generateImports(
          [
            ...useCases,
          ],
        ),
      )
      ..writeln(
        generateMain(),
      )
      ..writeln(
        generateWidgetbook(
          constructor: constructor,
          useCases: useCases,
          foldersExpanded: foldersExpanded,
          widgetsExpanded: widgetsExpanded,
          appBuilder: appBuilder.isNotEmpty ? appBuilder.first : null,
        ),
      );

    return buffer.toString();
  }
}

Constructor _getConstructor(ConstantReader annotation) {
  final index = annotation.read('constructor').read('index').intValue;
  return Constructor.values[index];
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
