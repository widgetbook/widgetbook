import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/constant/value.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

class AddonsConfigsBuilder extends Builder {
  @override
  final buildExtensions = const {
    '.dart': ['.config.widgetbook.json'],
  };

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;

    final library = LibraryReader(await buildStep.inputLibrary);
    final annotatedElements = library.annotatedWith(
      const TypeChecker.fromRuntime(App),
    );

    if (annotatedElements.isEmpty) return;
    if (annotatedElements.length > 1) {
      throw InvalidGenerationSourceError(
        'Only one class can be annotated with @App',
      );
    }

    final annotatedElement = annotatedElements.first;
    final appAnnotation = annotatedElement.annotation;

    final rawAddonsConfigs = !appAnnotation.read('cloudAddonsConfigs').isNull
        ? appAnnotation.read('cloudAddonsConfigs').mapValue
        : null;

    if (rawAddonsConfigs == null) return;

    final addonsConfigs = _parseAddonsConfigs(rawAddonsConfigs);
    final json = jsonEncode(addonsConfigs.toJson());

    return buildStep.writeAsString(
      buildStep.inputId.changeExtension('.config.widgetbook.json'),
      json,
    );
  }
}

AddonConfig _parseAddonConfig(
  DartObject addonConfig,
) {
  // The config could be extending the base [AddonConfig] class
  final target = addonConfig.getField('(super)') ?? addonConfig;
  final key = target.getField('key')!.toStringValue()!;
  final value = target.getField('value')!.toStringValue()!;

  return AddonConfig(key, value);
}

AddonsConfigs _parseAddonsConfigs(
  Map<DartObject?, DartObject?> addonsConfigs,
) {
  return addonsConfigs.entries.fold<AddonsConfigs>(
    {},
    (json, entry) {
      final configName = entry.key!.toStringValue()!;
      final addonConfigList = entry.value! //
          .toListValue()!
          .map(_parseAddonConfig)
          .toList();

      json[configName] = addonConfigList;

      return json;
    },
  );
}
