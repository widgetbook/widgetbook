// ignore_for_file: deprecated_member_use analyzer(<8.0.0)

import 'package:analyzer/dart/element/element2.dart';
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
    final storiesVariables =
        library.allElements
            .whereType<TopLevelVariableElement2>()
            .where((element) => element.displayName.startsWith('\$'))
            .toList();

    final metaVariable = library.allElements
        .whereType<TopLevelVariableElement2>()
        .firstWhere((element) => element.displayName == 'meta');

    final metaType = metaVariable.type as InterfaceType;
    final widgetType = metaType.typeArguments.first;
    final argsType = metaType.typeArguments.last;
    final path = buildStep.inputId.path;

    final hasSetup = library.allElements
        .whereType<TopLevelFunctionElement>()
        .any((element) => element.name == '\$setup');

    final hasArgsBuilder = library.allElements
        .whereType<TopLevelFunctionElement>()
        .any((element) => element.name == '\$argsBuilder');

    final genLib = Library(
      (b) =>
          b
            ..body.addAll(
              [
                ComponentBuilder(
                  widgetType,
                  argsType,
                  storiesVariables,
                  path,
                ).build(),
                ScenarioTypedefBuilder(widgetType, argsType).build(),
                StoryClassBuilder(
                  widgetType,
                  argsType,
                  hasSetup,
                  hasArgsBuilder,
                ).build(),
                ArgsClassBuilder(widgetType, argsType).build(),
              ],
            ),
    );

    final emitter = DartEmitter(
      useNullSafetySyntax: true,
    );

    return genLib.accept(emitter).toString();
  }
}
