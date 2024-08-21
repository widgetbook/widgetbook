import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:yaml/yaml.dart';

import '../models/element_metadata.dart';
import '../models/nav_path_mode.dart';
import '../models/use_case_metadata.dart';
import '../util/constant_reader.dart';

class UseCaseGenerator extends GeneratorForAnnotation<UseCase> {
  UseCaseGenerator(this.navPathMode);

  final packagesMapResource = Resource<YamlMap>(
    () async {
      final lockFile = await File('pubspec.lock').readAsString();
      final yaml = loadYaml(lockFile) as YamlMap;

      return yaml['packages'] as YamlMap;
    },
  );

  final NavPathMode navPathMode;

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

    final name = annotation.read('name').stringValue;
    final type = annotation.read('type').typeValue;
    final designLink = annotation.readOrNull('designLink')?.stringValue;
    final path = annotation.readOrNull('path')?.stringValue;

    final componentName = type
        .getDisplayString(
          // The `withNullability` parameter is deprecated after analyzer 6.0.0,
          // since we support analyzer 5.x (to support Dart <3.0.0), then
          // the deprecation is ignored.
          // ignore: deprecated_member_use
          withNullability: false,
        )
        // Generic widgets shouldn't have a "<dynamic>" suffix
        // if no type parameter is specified.
        .replaceAll('<dynamic>', '');

    final useCaseUri = resolveElementUri(element);
    final componentUri = resolveElementUri(type.element!);

    final useCasePath = await resolveElementPath(element, buildStep);
    final componentPath = await resolveElementPath(type.element!, buildStep);

    final targetNavUri = navPathMode == NavPathMode.component //
        ? componentUri
        : useCaseUri;

    final navPath = path ?? getNavPath(targetNavUri);

    final metadata = UseCaseMetadata(
      functionName: element.name!,
      designLink: designLink,
      name: name,
      importUri: useCaseUri,
      filePath: useCasePath,
      navPath: navPath,
      component: ElementMetadata(
        name: componentName,
        importUri: componentUri,
        filePath: componentPath,
      ),
    );

    const encoder = JsonEncoder.withIndent('  ');

    return encoder.convert(metadata.toJson());
  }

  /// Splits the [uri] into its parts, skipping both the `package:` and
  /// the `src` parts.
  ///
  /// For example, `package:widgetbook/src/widgets/foo/bar.dart`
  /// will be split into `['widgets', 'foo']`.
  static String getNavPath(String uri) {
    final directory = path.dirname(uri);
    final parts = path.split(directory);
    final hasSrc = parts.length >= 2 && parts[1] == 'src';

    return parts.skip(hasSrc ? 2 : 1).join('/');
  }

  /// Resolves the URI of an [element] by retrieving the URI from
  /// the [element]'s source.
  String resolveElementUri(Element element) {
    final source = element.librarySource ?? element.source!;
    return source.uri.toString();
  }

  /// Resolves the path of a local package by retrieving the path from
  /// the `pubspec.lock` file in case its name might not match its path.
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
    final elementPath = element.librarySource!.fullName;
    final elementPackage = element.librarySource!.uri.pathSegments[0];
    final inputPackage = buildStep.inputId.package;

    // If the element is in the same package as the `pubspec.lock` file,
    // then we cannot use the `pubspec.lock` file to resolve the path.
    // In this case, we can simply replace the package name with the
    // current directory name.
    if (elementPackage == inputPackage) {
      final currentDir = Directory.current.path;
      final dirName = path.basename(currentDir);

      return elementPath.replaceFirst(
        RegExp(elementPackage),
        dirName,
      );
    }

    final resource = await buildStep.fetchResource(packagesMapResource);
    final packageData = resource[elementPackage] as YamlMap;
    final isLocalPackage = packageData['source'] == 'path';

    if (!isLocalPackage) return elementPath;

    final packagePath = packageData['description']['path'] as String;
    final normalizedPackagePath = packagePath.replaceAll(
      RegExp(r'(\.)?\.\/'), // Match "./" and "../"
      '',
    );

    return elementPath.replaceFirst(
      RegExp(elementPackage),
      normalizedPackagePath,
    );
  }
}
