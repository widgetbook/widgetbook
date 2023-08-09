import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:yaml/yaml.dart';

import '../extensions/element_extensions.dart';
import '../extensions/json_list_formatter.dart';
import '../models/widgetbook_use_case_data.dart';

class UseCaseResolver extends GeneratorForAnnotation<UseCase> {
  final packagesMapResource = Resource<YamlMap>(
    () async {
      final lockFile = await File('pubspec.lock').readAsString();
      final yaml = loadYaml(lockFile) as YamlMap;

      return yaml['packages'] as YamlMap;
    },
  );

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element.isPrivate) {
      throw InvalidGenerationSourceError(
        'Widgetbook annotations cannot be applied to private methods',
        element: element,
      );
    }

    final useCaseName = annotation.read('name').stringValue;
    final typeElement = annotation.read('type').typeValue.element!;
    final designLinkReader = annotation.read('designLink');
    String? designLink;
    if (!designLinkReader.isNull) {
      designLink = designLinkReader.stringValue;
    }

    final typeValue = annotation.read('type').typeValue;
    final componentName = typeValue
        .getDisplayString(
          withNullability: false,
        )
        // Generic widgets shouldn't have a "<dynamic>" suffix
        // if no type parameter is specified.
        .replaceAll(
          '<dynamic>',
          '',
        );

    final data = WidgetbookUseCaseData(
      name: element.name!,
      useCaseName: useCaseName,
      componentName: componentName,
      importStatement: element.importStatement,
      componentImportStatement: typeElement.importStatement,
      dependencies: typeElement.dependencies,
      componentDefinitionPath: await resolveElementPath(typeElement, buildStep),
      useCaseDefinitionPath: await resolveElementPath(element, buildStep),
      designLink: designLink,
    );

    return [data].toJson();
  }

  /// This method resolves the path of a local package by retrieving
  /// the path from the `pubspec.lock` file because its name might not
  /// match its path.
  ///
  /// Example:
  /// A package with the name "shared_package" could be located in
  /// a folder named "shared". The path of the [element] would be
  /// `/shared_package/lib/...` which is not an actual path and should
  /// be resolved into `/shared/lib/...`.
  ///
  /// See also:
  /// - [#791](https://github.com/widgetbook/widgetbook/issues/791)
  Future<String> resolveElementPath(
    Element element,
    BuildStep buildStep,
  ) async {
    final path = element.librarySource!.fullName;
    final packageName = element.librarySource!.uri.pathSegments[0];
    final resource = await buildStep.fetchResource(packagesMapResource);

    // In case the package is the same as the `pubsec.lock` file's.
    if (!resource.containsKey(packageName)) return path;

    final packageData = resource[packageName] as YamlMap;
    final isLocalPackage = packageData['source'] == 'path';

    if (!isLocalPackage) return path;

    final packagePath = packageData['description']['path'] as String;

    return path.replaceFirst(
      RegExp(packageName),
      packagePath,
    );
  }
}
