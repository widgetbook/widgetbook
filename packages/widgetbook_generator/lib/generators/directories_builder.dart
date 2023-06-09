import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

import '../instances/instance.dart';
import '../instances/list_instance.dart';
import '../instances/widgetbook_folder_instance.dart';
import '../instances/widgetbook_widget_instance.dart';
import '../models/widgetbook_use_case_data.dart';
import 'tree_service.dart';

class DirectoriesBuilder extends Builder {
  static const filename = 'widgetbook.directories.g.dart';

  static const ignoredLintRules = {
    'unused_import',
    'prefer_relative_imports',
    'directives_ordering',
  };

  static final headerParts = [
    '// coverage:ignore-file',
    '// ignore_for_file: type=lint',
    '// ignore_for_file: ${ignoredLintRules.join(", ")}',
    '',
    defaultFileHeader,
    '',
    '// '.padRight(77, '*'),
    '// WidgetbookGenerator',
    '// '.padRight(77, '*'),
  ];

  @override
  final buildExtensions = const {
    r'$lib$': [filename]
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final useCases = await findUseCases(buildStep);
    final packages = collectImportPackages(useCases);
    final instances = collectInstances(useCases);
    final rootInstance = ListInstance(
      instances: instances,
    ).toCode();

    final content = '${headerParts.join('\n')}'
        '\n\n'
        '${packages.map((package) => "import '$package';").join('\n')}'
        '\n\n'
        'final directories = $rootInstance;';

    buildStep.writeAsString(
      AssetId(buildStep.inputId.package, 'lib/$filename'),
      content,
    );
  }

  Future<List<WidgetbookUseCaseData>> findUseCases(
    BuildStep buildStep,
  ) async {
    final assets = await buildStep
        .findAssets(Glob('**.usecase.widgetbook.json'))
        .asyncMap((asset) => buildStep.readAsString(asset))
        .map((json) => jsonDecode(json) as List)
        .map((list) => list.cast<Map<String, dynamic>>())
        .toList();

    return assets.flattened.map(WidgetbookUseCaseData.fromJson).toList();
  }

  Set<String> collectImportPackages(
    List<WidgetbookUseCaseData> useCases,
  ) {
    return {
      'package:flutter/material.dart',
      'package:widgetbook/widgetbook.dart',
      for (final useCase in useCases) ...{
        useCase.importStatement,
        ...useCase.dependencies,
      }
    };
  }

  List<Instance> collectInstances(
    List<WidgetbookUseCaseData> useCases,
  ) {
    final service = TreeService();

    for (final useCase in useCases) {
      final folder = service.addFolderByImport(
        useCase.componentImportStatement,
      );

      service.addStoryToFolder(folder, useCase);
    }

    return [
      ...service.folders.values.map(
        (folder) => WidgetbookFolderInstance(
          folder: folder,
        ),
      ),
      ...service.rootFolder.widgets.values.map(
        (widget) => WidgetbookComponentInstance(
          name: widget.name,
          stories: widget.stories,
        ),
      ),
    ];
  }
}
