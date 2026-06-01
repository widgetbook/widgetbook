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

/// A discovered `Meta<TWidget>` variable in a `.stories.dart` file.
///
/// A file may declare more than one meta (one per constructor variant)
/// to group multiple constructors of the same widget under a single
/// generated `${Widget}Component`. One of the metas is selected as
/// canonical and provides the component's `name`, `path`, and `docsBuilder`;
/// see `_selectCanonical` for the resolution rules.
class _MetaInfo {
  _MetaInfo({
    required this.variableName,
    required this.widgetType,
    required this.argsType,
    required this.constructorName,
  });

  final String variableName;
  final DartType widgetType;
  final DartType argsType;
  final String? constructorName;
}

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

    final metas = _collectMetas(library);
    if (metas.isEmpty) {
      throw StateError(
        'A .stories.dart file must declare at least one top-level '
        '`Meta<TWidget>` variable.',
      );
    }
    final defaultMeta = _selectCanonical(metas);

    final isMultiMeta = metas.length > 1;
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
      defaultMeta.widgetType,
      defaultMeta.argsType,
      storiesVariables,
      path,
      defaultMeta.constructorName,
      isMultiMeta: isMultiMeta,
    );

    // Scenario and Defaults typedefs are file-scoped; they reference the
    // canonical meta's args (i.e., the meta named `meta`). The
    // constructorName determines whether their class names and the args they
    // reference get the constructor prefix.
    final scenarioBuilder = ScenarioTypedefBuilder(
      defaultMeta.widgetType,
      defaultMeta.argsType,
      defaultMeta.constructorName,
    );

    final defaultsBuilder = DefaultsTypedefBuilder(
      defaultMeta.widgetType,
      defaultMeta.argsType,
      defaultMeta.constructorName,
    );

    // One Args + Story class pair per meta. Each builder derives its own
    // class prefix from the meta's constructor name. Only the default meta
    // receives user-provided `defaults` (setup/builder); they don't apply to
    // other constructor variants.
    final argsBuilders = metas
        .map(
          (m) => ArgsClassBuilder(
            m.widgetType,
            m.argsType,
            m.constructorName,
          ),
        )
        .toList();

    final storyBuilders = metas
        .map(
          (m) => StoryClassBuilder(
            m.widgetType,
            m.argsType,
            m.variableName == 'meta' ? defaultSetup : null,
            m.variableName == 'meta' ? defaultBuilder : null,
            m.constructorName,
          ),
        )
        .toList();

    final genLib = Library(
      (b) => b
        ..body.addAll(
          [
            componentBuilder.buildUnderscoreType(),
            scenarioBuilder.buildUnderscoreType(),
            defaultsBuilder.buildUnderscoreType(),
            for (final sb in storyBuilders) sb.buildUnderscoreType(),
            for (final ab in argsBuilders) ab.buildUnderscoreType(),

            componentBuilder.build(),
            scenarioBuilder.build(),
            defaultsBuilder.build(),
            for (final sb in storyBuilders) sb.build(),
            for (final ab in argsBuilders) ab.build(),
          ],
        ),
    );

    final emitter = DartEmitter(
      useNullSafetySyntax: true,
    );

    return genLib.accept(emitter).toString();
  }

  /// Picks the canonical meta whose `name`, `path`, `docsBuilder`, and args
  /// type the file-level Component / Scenario / Defaults reference.
  ///
  /// Resolution order:
  /// 1. A variable explicitly named `meta` (the documented convention).
  /// 2. A meta targeting the default (unnamed) constructor.
  /// 3. The first meta declared.
  _MetaInfo _selectCanonical(List<_MetaInfo> metas) {
    for (final m in metas) {
      if (m.variableName == 'meta') return m;
    }
    for (final m in metas) {
      if (m.constructorName == null) return m;
    }
    return metas.first;
  }

  /// Collects every top-level `Meta<TWidget>` (or `MetaWithArgs<...>`)
  /// variable declared in [library].
  List<_MetaInfo> _collectMetas(LibraryReader library) {
    final metaVariables = library.allElements
        .whereType<TopLevelVariableElement>()
        .where((element) {
          final type = element.type;
          if (type is! InterfaceType) return false;
          final name = type.element.name;
          return name == 'Meta' || name == 'MetaWithArgs';
        })
        .toList();

    return metaVariables.map((v) {
      final metaType = v.type as InterfaceType;
      return _MetaInfo(
        variableName: v.displayName,
        widgetType: metaType.typeArguments.first,
        argsType: metaType.typeArguments.last,
        constructorName: getConstructorName(
          library.element,
          variableName: v.displayName,
        ),
      );
    }).toList();
  }

  /// Parses the `constructor:` argument from a `Meta` variable initializer
  /// to extract the named constructor (e.g., `'icon'` from `Button.icon`).
  ///
  /// Returns `null` for the default (unnamed) constructor.
  String? getConstructorName(
    LibraryElement element, {
    String variableName = 'meta',
  }) {
    final result = element.session.getParsedLibraryByElement(element);
    if (result is! ParsedLibraryResult) return null;

    final initializer = result.units
        .expand((u) => u.unit.declarations)
        .whereType<TopLevelVariableDeclaration>()
        .expand((d) => d.variables.variables)
        .firstWhereOrNull((v) => v.name.lexeme == variableName)
        ?.initializer;

    ArgumentList? argumentList;
    if (initializer is MethodInvocation) {
      argumentList = initializer.argumentList;
    } else if (initializer is InstanceCreationExpression) {
      argumentList = initializer.argumentList;
    }
    if (argumentList == null) return null;

    final constructorArg = argumentList.arguments
        .whereType<NamedExpression>()
        .firstWhereOrNull((arg) => arg.name.label.name == 'constructor');
    if (constructorArg == null) return null;

    final expression = constructorArg.expression;

    // Extract the constructor name from the tear-off expression.
    // Button.icon → PrefixedIdentifier(Button, icon)
    // w.Button.icon → PropertyAccess(PrefixedIdentifier(w, Button), icon)
    final name = switch (expression) {
      PrefixedIdentifier() => expression.identifier.name,
      PropertyAccess() => expression.propertyName.name,
      _ => null,
    };

    // 'new' refers to the unnamed constructor
    return name == 'new' ? null : name;
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
