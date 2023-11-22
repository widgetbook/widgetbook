import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

import 'args_class_builder.dart';
import 'story_class_builder.dart';

class StoryGenerator extends Generator {
  @override
  Future<String> generate(
    LibraryReader library,
    BuildStep buildStep,
  ) async {
    final metadataVariable = library.allElements
        .whereType<TopLevelVariableElement>()
        .firstWhere((element) => element.name == 'metadata');

    final widgetType = metadataVariable
        .computeConstantValue()!
        .getField('type')!
        .toTypeValue()!;

    final genLib = Library(
      (b) => b
        ..body.addAll(
          [
            StoryClassBuilder(widgetType).build(),
            ArgsClassBuilder(widgetType).build(),
          ],
        ),
    );

    return genLib.accept(DartEmitter()).toString();
  }
}
