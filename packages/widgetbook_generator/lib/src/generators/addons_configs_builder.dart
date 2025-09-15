import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../util/constant_reader.dart';
import 'base_builder.dart';

class AddonsConfigsBuilder extends BaseBuilder {
  static const extension = '.config.widgetbook.json';
  static const checker = TypeChecker.typeNamed(
    App,
    inPackage: 'widgetbook_annotation',
  );

  @override
  final buildExtensions = const {
    '.dart': [extension],
  };

  @override
  Future<void> buildForLibrary(
    BuildStep buildStep,
    LibraryReader library,
  ) async {
    final annotatedElements = library.annotatedWith(checker);

    if (annotatedElements.isEmpty) return;
    if (annotatedElements.length > 1) {
      throw InvalidGenerationSourceError(
        'Only one class can be annotated with @App',
      );
    }

    final annotatedElement = annotatedElements.first;
    final appAnnotation = annotatedElement.annotation;
    final addonsConfigs = appAnnotation
        .readOrNull('cloudAddonsConfigs')
        ?.parse(_parseAddonsConfigs);

    if (addonsConfigs == null) return;

    final json = jsonEncode(addonsConfigs.toJson());

    return buildStep.writeAsString(
      buildStep.inputId.changeExtension(extension),
      json,
    );
  }

  AddonsConfigs _parseAddonsConfigs(
    ConstantReader reader,
  ) {
    final rawMap = reader.mapValue.map(
      (key, value) => MapEntry(
        key!.toStringValue()!,
        value!.toListValue()!,
      ),
    );

    return {
      for (final entry in rawMap.entries)
        entry.key: entry.value.map(
          (e) {
            final reader = ConstantReader(e);
            final key = reader.read('key').stringValue;

            if (key == 'viewport') {
              final data = reader.read('value');
              final name = data.read('name').stringValue;
              final ratio = data.read('pixelRatio').doubleValue;
              final width = data.read('width').doubleValue;
              final height = data.read('height').doubleValue;

              return AddonConfig(
                key,
                'name:$name,\$meta:{w:$width,h:$height,p:$ratio}',
              );
            }

            return AddonConfig(
              key,
              reader.read('value').stringValue,
            );
          },
        ),
    };
  }
}
