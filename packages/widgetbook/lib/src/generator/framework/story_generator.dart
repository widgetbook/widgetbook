import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart' hide Expression;
import 'package:source_gen/source_gen.dart';

import 'args_class_builder.dart';
import 'component_builder.dart';
import 'defaults_typedef_builder.dart';
import 'extensions.dart';
import 'scenario_typedef_builder.dart';
import 'story_class_builder.dart';
import 'variant.dart';

class StoryGenerator extends Generator {
  @override
  Future<String> generate(
    LibraryReader library,
    BuildStep buildStep,
  ) async {
    final topLevelVariables = library.allElements
        .whereType<TopLevelVariableElement>()
        .toList();

    final storiesVariables = topLevelVariables
        .where((element) => element.displayName.startsWith('\$'))
        .toList();

    final variants = getVariants(topLevelVariables);
    final metaVariable = getComponentMetaVariable(topLevelVariables);
    final widgetType = variants.first.widgetType;

    validateVariants(variants, widgetType);

    final initializers = getTopLevelInitializers(library.element);
    final path = buildStep.inputId.path;

    final componentBuilder = ComponentBuilder(
      widgetType,
      storiesVariables,
      path,
      metaVariable?.displayName,
    );

    final variantBuilders = variants.map((variant) {
      final defaults = getDefaults(variant, initializers);

      return (
        scenario: ScenarioTypedefBuilder(variant),
        defaults: DefaultsTypedefBuilder(variant),
        story: StoryClassBuilder(
          variant,
          defaults?.setup,
          defaults?.builder,
          defaults?.variableName,
        ),
        args: ArgsClassBuilder(variant),
      );
    }).toList();

    final genLib = Library(
      (b) => b
        ..body.addAll(
          [
            componentBuilder.buildUnderscoreType(),
            for (final builders in variantBuilders) ...[
              builders.scenario.buildUnderscoreType(),
              builders.defaults.buildUnderscoreType(),
              builders.story.buildUnderscoreType(),
              builders.args.buildUnderscoreType(),
            ],

            componentBuilder.build(),
            for (final builders in variantBuilders) ...[
              builders.scenario.build(),
              builders.defaults.build(),
              builders.story.build(),
              builders.args.build(),
            ],
          ],
        ),
    );

    final emitter = DartEmitter(
      useNullSafetySyntax: true,
    );

    return genLib.accept(emitter).toString();
  }

  /// Finds the optional top-level `ComponentMeta` variable of the stories
  /// file, used to customize the component's name/path/docsBuilder.
  TopLevelVariableElement? getComponentMetaVariable(
    List<TopLevelVariableElement> variables,
  ) {
    final matches = variables.where((variable) {
      final type = variable.type;
      return type is InterfaceType && type.element.name == 'ComponentMeta';
    }).toList();

    if (matches.length > 1) {
      throw InvalidGenerationSourceError(
        'Found multiple `ComponentMeta` variables '
        '(${matches.map((variable) => variable.displayName).join(', ')}), '
        'but each stories file can only define one.',
        element: matches[1],
      );
    }

    return matches.firstOrNull;
  }

  /// Resolves all top-level `Meta` variables into [Variant]s.
  List<Variant> getVariants(List<TopLevelVariableElement> variables) {
    final variants = variables.map(Variant.fromVariable).nonNulls.toList();

    if (variants.isEmpty) {
      throw InvalidGenerationSourceError(
        'No `Meta` variable found. Define at least one variant, '
        'e.g. `const meta = Meta(MyWidget.new)`.',
      );
    }

    return variants;
  }

  /// Validates that all [variants] target the component [widgetType] and
  /// that their generated type names cannot collide.
  void validateVariants(List<Variant> variants, InterfaceType widgetType) {
    final byPrefix = <String, Variant>{};
    final byArgsClassName = <String, Variant>{};

    for (final variant in variants) {
      if (variant.constructor.enclosingElement != widgetType.element) {
        throw InvalidGenerationSourceError(
          '`${variant.metaVariable.displayName}` references a constructor of '
          '`${variant.constructor.enclosingElement.name}`, but the component '
          'widget is `${widgetType.element.name}`. All `Meta` variables in a '
          'stories file must target the same widget.',
          element: variant.metaVariable,
        );
      }

      final samePrefix = byPrefix[variant.prefix];
      if (samePrefix != null) {
        throw InvalidGenerationSourceError(
          '`${variant.metaVariable.displayName}` and '
          '`${samePrefix.metaVariable.displayName}` both target the '
          '`${variant.constructor.displayName}` constructor, but each '
          'constructor can only have one `Meta` variable.',
          element: variant.metaVariable,
        );
      }

      final sameArgs = byArgsClassName[variant.argsClassName];
      if (sameArgs != null) {
        throw InvalidGenerationSourceError(
          '`${variant.metaVariable.displayName}` and '
          '`${sameArgs.metaVariable.displayName}` both generate an args '
          'class named `${variant.argsClassName}`, but each variant must '
          'have a distinct args type.',
          element: variant.metaVariable,
        );
      }

      byPrefix[variant.prefix] = variant;
      byArgsClassName[variant.argsClassName] = variant;
    }
  }

  /// Parses the initializers of all top-level variables in the library.
  /// As generated types (e.g. `_Defaults`) cannot be resolved while their
  /// part file is being generated, the initializers can only be inspected
  /// syntactically.
  Map<String, ({String typeName, ArgumentList arguments})>
  getTopLevelInitializers(
    LibraryElement element,
  ) {
    final result = element.session.getParsedLibraryByElement(element);

    if (result is! ParsedLibraryResult) {
      return {};
    }

    final variables = result.units
        .expand((unit) => unit.unit.declarations)
        .whereType<TopLevelVariableDeclaration>()
        .expand((declaration) => declaration.variables.variables);

    return {
      for (final variable in variables)
        if (getInvocation(variable.initializer) case final invocation?)
          variable.name.lexeme: invocation,
    };
  }

  /// Extracts the invoked type name and arguments from an [initializer].
  /// In an unresolved AST, `_Defaults(...)` is a [MethodInvocation], while
  /// `const _Defaults(...)` is an [InstanceCreationExpression].
  ({String typeName, ArgumentList arguments})? getInvocation(
    Expression? initializer,
  ) {
    return switch (initializer) {
      MethodInvocation(:final methodName, :final argumentList) => (
        typeName: methodName.name,
        arguments: argumentList,
      ),
      InstanceCreationExpression(:final constructorName, :final argumentList)
          when constructorName.name == null =>
        (
          typeName: constructorName.type.name.lexeme,
          arguments: argumentList,
        ),
      _ => null,
    };
  }

  /// Finds the defaults variable for [variant] by matching the initializer
  /// against the variant's defaults type names (e.g. `_Defaults(...)` or
  /// `MyWidgetDefaults(...)`), then extracts the names of the arguments that
  /// have been provided (i.e., those that are not null).
  /// The name of the variable itself does not matter.
  ({String variableName, Code? setup, Code? builder})? getDefaults(
    Variant variant,
    Map<String, ({String typeName, ArgumentList arguments})> initializers,
  ) {
    final typeNames = {
      '_${variant.prefix}Defaults',
      '${variant.widgetType.nonGenericName}${variant.prefix}Defaults',
    };

    final matches = initializers.entries
        .where((entry) => typeNames.contains(entry.value.typeName))
        .toList();

    if (matches.length > 1) {
      throw InvalidGenerationSourceError(
        'Found multiple defaults variables '
        '(${matches.map((match) => match.key).join(', ')}) for '
        '`${variant.metaVariable.displayName}`, but each variant can only '
        'have one.',
        element: variant.metaVariable,
      );
    }

    if (matches.isEmpty) {
      return null;
    }

    final match = matches.single;
    final arguments = match.value.arguments.arguments
        .whereType<NamedExpression>()
        .where((arg) => arg.expression is! NullLiteral);

    final args = {
      for (final arg in arguments)
        arg.name.label.name: Code(arg.expression.toString()),
    };

    return (
      variableName: match.key,
      setup: args['setup'],
      builder: args['builder'],
    );
  }
}
