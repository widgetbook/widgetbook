import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

import 'args_class_builder.dart';
import 'component_builder.dart';
import 'scenario_typedef_builder.dart';
import 'story_class_builder.dart';

class StoryGenerator extends Generator {
  @override
  Future<String> generate(
    LibraryReader library,
    BuildStep buildStep,
  ) async {
    final storiesVariables = library.allElements
        .whereType<TopLevelVariableElement>()
        .where((element) => element.name.startsWith('\$'))
        .toList();

    final metaVariable = library.allElements
        .whereType<TopLevelVariableElement>()
        .firstWhere((element) => element.name == 'meta');

    final metaType = metaVariable.type as InterfaceType;
    final widgetType = metaType.typeArguments.first;
    final argsType = metaType.typeArguments.last;

    final genLib = Library(
      (b) => b
        ..body.addAll(
          [
            ComponentBuilder(widgetType, argsType, storiesVariables).build(),
            ScenarioTypedefBuilder(widgetType, argsType).build(),
            StoryClassBuilder(widgetType, argsType).build(),
            ArgsClassBuilder(widgetType, argsType).build(),
          ],
        ),
    );

    return genLib.accept(DartEmitter()).toString();
  }
}
