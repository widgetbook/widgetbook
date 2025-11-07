import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../code/refer.dart';
import '../code/resolver_allocator.dart';
import '../code/widgetbook_instance.dart';
import '../models/use_case_metadata.dart';
import '../tree/tree.dart';

/// Generates the `directories` variable for Widgetbook.
///
/// The generated files is located in the same directory in which the [App]
/// annotation is used.
class AppGenerator extends GeneratorForAnnotation<App> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    // The directory containing the `widgetbook.dart` file
    // without the leading `/`
    final inputPath = element.library!.firstFragment.source.fullName;
    final inputDir = path.dirname(inputPath).substring(1);

    final emitter = DartEmitter(
      allocator: ResolverAllocator(inputDir),
      orderDirectives: true,
    );

    final useCases = await readUseCases(buildStep);
    final root = Tree.build(useCases);
    final library = buildLibrary(root.instances);

    return library.accept(emitter).toString();
  }

  static Future<List<UseCaseMetadata>> readUseCases(
    BuildStep buildStep,
  ) async {
    final glob = Glob('**.usecase.widgetbook.json');
    final assets = await buildStep
        .findAssets(glob)
        .asyncMap((asset) => buildStep.readAsString(asset))
        .map((json) => jsonDecode(json) as List)
        .map((list) => list.cast<Map<String, dynamic>>())
        .toList();

    return assets
        .flattened //
        .map(UseCaseMetadata.fromJson)
        .toList();
  }

  Library buildLibrary(
    List<WidgetbookInstance> instances,
  ) {
    final variable = declareFinal('directories');
    final nodesValue = literalList(
      instances,
      referWidgetbook('WidgetbookNode'),
    );

    return Library(
      (b) {
        b.body.add(
          variable.assign(nodesValue).statement,
        );
      },
    );
  }
}
