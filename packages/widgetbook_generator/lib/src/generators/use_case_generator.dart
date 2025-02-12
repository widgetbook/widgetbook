import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../models/element_metadata.dart';
import '../models/nav_path_mode.dart';
import '../models/use_case_metadata.dart';
import '../util/constant_reader.dart';

class UseCaseGenerator extends GeneratorForAnnotation<UseCase> {
  UseCaseGenerator(this.navPathMode);

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

    final targetNavUri = navPathMode == NavPathMode.component //
        ? componentUri
        : useCaseUri;

    final navPath = path ?? getNavPath(targetNavUri);

    final metadata = UseCaseMetadata(
      functionName: element.name!,
      designLink: designLink,
      name: name,
      importUri: useCaseUri,
      navPath: navPath,
      component: ElementMetadata(
        name: componentName,
        importUri: componentUri,
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
}
