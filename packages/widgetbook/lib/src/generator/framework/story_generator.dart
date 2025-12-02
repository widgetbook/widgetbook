import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

import 'args_class_builder.dart';
import 'component_builder.dart';
import 'defaults_typedef_builder.dart';
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
        .where((element) => element.displayName.startsWith('\$'))
        .toList();

    final metaVariable = library.allElements
        .whereType<TopLevelVariableElement>()
        .firstWhere((element) => element.displayName == 'meta');

    final metaType = metaVariable.type as InterfaceType;
    final widgetType = metaType.typeArguments.first;
    final argsType = metaType.typeArguments.last;
    final path = buildStep.inputId.path;

    final defaultsVariable = library.allElements
        .whereType<TopLevelVariableElement>()
        .firstWhereOrNull((element) => element.displayName == 'defaults');

    // We only do this expensive parsing if defaults are defined
    final defaultsArgs = defaultsVariable != null
        ? getDefaultsArgs(library.element)
        : null;

    final defaultSetup = defaultsArgs?['setup'];
    final defaultBuilder = defaultsArgs?['builder'];

    final componentBuilder = ComponentBuilder(
      widgetType,
      argsType,
      storiesVariables,
      path,
    );

    final scenarioBuilder = ScenarioTypedefBuilder(
      widgetType,
      argsType,
    );

    final defaultsBuilder = DefaultsTypedefBuilder(
      widgetType,
      argsType,
    );

    final storyBuilder = StoryClassBuilder(
      widgetType,
      argsType,
      defaultSetup,
      defaultBuilder,
    );

    final argsBuilder = ArgsClassBuilder(
      widgetType,
      argsType,
    );

    final genLib = Library(
      (b) => b
        ..body.addAll(
          [
            componentBuilder.buildUnderscoreType(),
            scenarioBuilder.buildUnderscoreType(),
            defaultsBuilder.buildUnderscoreType(),
            storyBuilder.buildUnderscoreType(),
            argsBuilder.buildUnderscoreType(),

            componentBuilder.build(),
            scenarioBuilder.build(),
            defaultsBuilder.build(),
            storyBuilder.build(),
            argsBuilder.build(),
          ],
        ),
    );

    final emitter = DartEmitter(
      useNullSafetySyntax: true,
    );

    return genLib.accept(emitter).toString();
  }

  /// Parses the 'defaults' variable to extract the names of the arguments that
  /// have been provided (i.e., those that are not null).
  Map<String, Code>? getDefaultsArgs(LibraryElement element) {
    final result = element.session.getParsedLibraryByElement(element);

    if (result is! ParsedLibraryResult) {
      return null;
    }

    final initializer = result.units
        .expand((u) => u.unit.declarations)
        .whereType<TopLevelVariableDeclaration>()
        .expand((d) => d.variables.variables)
        .firstWhereOrNull((v) => v.name.lexeme == 'defaults')
        ?.initializer;

    if (initializer is! MethodInvocation) {
      return null;
    }

    final arguments = initializer.argumentList.arguments
        .whereType<NamedExpression>()
        .where((arg) => arg.expression is! NullLiteral);

    return {
      for (final arg in arguments)
        arg.name.label.name: Code(arg.expression.toString()),
    };
  }
}
