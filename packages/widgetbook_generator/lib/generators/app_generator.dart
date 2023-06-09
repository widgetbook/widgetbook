import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../instances/instance.dart';
import '../instances/list_instance.dart';
import '../instances/widgetbook_folder_instance.dart';
import '../instances/widgetbook_widget_instance.dart';
import '../models/widgetbook_data.dart';
import '../models/widgetbook_use_case_data.dart';
import 'tree_service.dart';

/// Generates the code for Widgetbook
///
/// The code is located at the same location in which the [App]
/// annotation is used.
class AppGenerator extends GeneratorForAnnotation<App> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final useCases = await loadDataFromJson<WidgetbookUseCaseData>(
      buildStep,
      '**.usecase.widgetbook.json',
      WidgetbookUseCaseData.fromJson,
    );

    final buffer = StringBuffer()
      ..writeln(generateImports(useCases))
      ..writeln(generateDirectories(useCases));

    return buffer.toString();
  }

  Future<List<T>> loadDataFromJson<T>(
    BuildStep buildStep,
    String extension,
    T Function(Map<String, dynamic> map) fromMap,
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

  /// Generates the directories of Widgetbook
  String generateDirectories(
    List<WidgetbookUseCaseData> useCases,
  ) {
    final directories = _generateDirectoriesInstances(useCases);

    final instance = ListInstance(
      instances: directories,
    ).toCode();

    return 'final directories = $instance;';
  }

  /// generates the imports for all the types used in widgetbook.g.dart
  ///
  /// the code returned likely contains unneccesary imports
  /// but this implementation is simple in comparison to a complex approach
  String generateImports(
    List<WidgetbookData> datas,
  ) {
    final set = <String>{};

    for (final data in datas) {
      set
        ..add(data.importStatement)
        ..addAll(data.dependencies);
    }

    set
      ..add('package:flutter/material.dart')
      ..add('package:widgetbook/widgetbook.dart')
      ..remove('package:widgetbook_annotation/widgetbook_annotation.dart');

    final imports = set.map(_generateImportStatement).toList()
      ..sort((a, b) => a.compareTo(b));

    return imports.join('\n');
  }

  String _generateImportStatement(String import) {
    return "import '$import';";
  }

  List<Instance> _generateDirectoriesInstances(
    List<WidgetbookUseCaseData> useCases,
  ) {
    final service = TreeService();

    for (final useCase in useCases) {
      final folder =
          service.addFolderByImport(useCase.componentImportStatement);
      service.addStoryToFolder(folder, useCase);
    }

    return [
      ...service.folders.values.map(
        (e) => WidgetbookFolderInstance(folder: e),
      ),
      ...service.rootFolder.widgets.values.map(
        (e) => WidgetbookComponentInstance(
          name: e.name,
          stories: e.stories,
        ),
      ),
    ];
  }
}
