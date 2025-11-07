import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../models/element_metadata.dart';
import '../models/nav_path_mode.dart';
import '../models/use_case_metadata.dart';
import '../util/constant_reader.dart';
import '../util/dart_object.dart';

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
    final exclude = annotation.read('exclude').boolValue;

    if (exclude) return '';

    final cloudExclude = annotation.read('cloudExclude').boolValue;
    final knobsConfigs =
        annotation //
            .readOrNull('cloudKnobsConfigs')
            ?.parse(_parseKnobsConfigs);

    final componentName = type
        .getDisplayString()
        // Generic widgets shouldn't have a "<dynamic>" suffix
        // if no type parameter is specified.
        .replaceAll('<dynamic>', '');

    final useCaseUri = resolveElementUri(element);
    final componentUri = resolveElementUri(type.element!);

    final targetNavUri = navPathMode == NavPathMode.component
        ? componentUri
        : useCaseUri;

    final navPath = path ?? getNavPath(targetNavUri);

    final metadata = UseCaseMetadata(
      functionName: element.firstFragment.name!,
      designLink: designLink,
      name: name,
      importUri: useCaseUri,
      navPath: navPath,
      cloudExclude: cloudExclude,
      knobsConfigs: knobsConfigs?.toJson(),
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
    final source =
        element.firstFragment.libraryFragment?.source ??
        element.library!.firstFragment.source;
    return source.uri.toString();
  }

  KnobsConfigs _parseKnobsConfigs(
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

            // A special type of KnobConfig is the MultiFieldKnobConfig
            // This allows users to configure more than one field.
            // Since for first-class knobs we have 1-1 relation between
            // knob and field (i.e. each knob has only one field),
            // we need to convert the MultiFieldKnobConfig into
            // multiple KnobConfig (i.e. multiple fields).
            if (e.type.toString() == '$MultiFieldKnobConfig') {
              final fields = reader.read('value').mapValue;

              return fields.entries.map(
                // Add each field as a separate KnobConfig
                (entry) {
                  return KnobConfig(
                    entry.key!.toStringValue()!,
                    entry.value?.toPrimitiveValue(),
                  );
                },
              ).toList();
            }

            return [
              KnobConfig(
                reader.read('label').stringValue,
                reader.read('value').literalValue,
              ),
            ];
          },
        ).flattened,
    };
  }
}
