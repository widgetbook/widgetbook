import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

import 'extensions.dart';

class StoryClassBuilder {
  StoryClassBuilder(
    this.widgetType,
    this.argsType,
    this.hasSetup,
    this.hasArgsBuilder,
  );

  final DartType widgetType;
  final DartType argsType;
  final bool hasSetup;
  final bool hasArgsBuilder;

  Iterable<FormalParameterElement> get params {
    return (argsType.element as ClassElement)
        .constructors
        .first
        .formalParameters;
  }

  Set<Reference> getTypeParams({bool withBounds = true}) {
    return {
      ...widgetType.getTypeParams(withBounds: withBounds),
      ...argsType.getTypeParams(withBounds: withBounds),
    };
  }

  Class build() {
    final isCustomArgs = widgetType != argsType;
    final hasRequiredArgs = params.any((param) => param.requiresArg);
    final unboundedTypeParams = getTypeParams(withBounds: false);

    final widgetClassRef = widgetType.getRef();

    final storyClassRef = widgetType.getRef(
      suffix: 'Story',
      types: unboundedTypeParams,
    );

    final argsClassRef = argsType.getRef(
      suffix: 'Args',
      types: unboundedTypeParams,
    );

    final nullableArgsClassRef = argsType.getRef(
      suffix: 'Args',
      types: unboundedTypeParams,
      isNullable: true,
    );

    return Class(
      (b) =>
          b
            ..name = storyClassRef.symbol
            ..types.addAll(getTypeParams())
            ..extend = TypeReference(
              (b) =>
                  b
                    ..symbol = 'Story'
                    ..types.addAll([widgetClassRef, argsClassRef]),
            )
            ..constructors.add(
              Constructor(
                (b) {
                  b.optionalParameters.addAll([
                    Parameter(
                      (b) =>
                          b
                            ..name = 'name'
                            ..named = true
                            ..toSuper = true,
                    ),
                    Parameter(
                      (b) =>
                          b
                            ..name = 'setup'
                            ..named = true
                            ..toSuper = !hasArgsBuilder
                            ..type =
                                !hasArgsBuilder
                                    ? null
                                    : TypeReference(
                                      (b) =>
                                          b
                                            ..symbol = 'SetupBuilder'
                                            ..isNullable = true
                                            ..types.addAll([
                                              widgetClassRef,
                                              argsClassRef,
                                            ]),
                                    ),
                    ),
                    Parameter(
                      (b) =>
                          b
                            ..name = 'args'
                            ..named = true
                            ..toSuper = hasRequiredArgs
                            ..required = hasRequiredArgs
                            ..type =
                                hasRequiredArgs ? null : nullableArgsClassRef,
                    ),
                    Parameter(
                      (b) =>
                          b
                            ..name = 'argsBuilder'
                            ..named = true
                            ..toSuper = isCustomArgs && !hasArgsBuilder
                            ..required = isCustomArgs && !hasArgsBuilder
                            ..type =
                                isCustomArgs && !hasArgsBuilder
                                    ? null
                                    : TypeReference(
                                      (b) =>
                                          b
                                            ..symbol = 'ArgsBuilder'
                                            ..isNullable = true
                                            ..types.addAll([
                                              widgetClassRef,
                                              argsClassRef,
                                            ]),
                                    ),
                    ),
                    Parameter(
                      (b) =>
                          b
                            ..name = 'scenarios'
                            ..named = true
                            ..toSuper = true,
                    ),
                    Parameter(
                      (b) =>
                          b
                            ..name = 'scenariosViewport'
                            ..named = true
                            ..toSuper = true,
                    ),
                  ]);

                  final superInitializers = {
                    if (!hasRequiredArgs)
                      'args': refer('args').ifNullThen(
                        InvokeExpression.newOf(
                          argsClassRef,
                          [],
                        ),
                      ),
                    if (!isCustomArgs && !hasArgsBuilder)
                      'argsBuilder': refer('argsBuilder').ifNullThen(
                        Method(
                          (b) =>
                              b
                                ..lambda = true
                                ..requiredParameters.addAll([
                                  Parameter((b) => b.name = 'context'),
                                  Parameter((b) => b.name = 'args'),
                                ])
                                ..body =
                                    instantiate(
                                      (param) => refer('args') //
                                          .property(param.displayName)
                                          .maybeProperty(
                                            'resolve',
                                            nullSafe: param.type.isNullable,
                                          )
                                          .call([refer('context')]),
                                    ).code,
                        ).closure,
                      ),
                    if (hasArgsBuilder)
                      'argsBuilder': refer('argsBuilder').ifNullThen(
                        refer('\$argsBuilder'),
                      ),
                    if (hasSetup)
                      'setup': refer('setup').ifNullThen(
                        refer('\$setup'),
                      ),
                  };

                  if (superInitializers.isNotEmpty) {
                    b.initializers.add(
                      refer('super')
                          .call(
                            [],
                            superInitializers,
                          )
                          .code,
                    );
                  }
                },
              ),
            )
            ..methods.add(
              Method(
                (b) =>
                    b
                      ..name = 'init'
                      ..annotations.add(refer('override'))
                      ..optionalParameters.add(
                        Parameter(
                          (b) =>
                              b
                                ..name = 'name'
                                ..named = true
                                ..required = true
                                ..type = refer('String'),
                        ),
                      )
                      ..returns = storyClassRef
                      ..lambda = true
                      ..body =
                          InvokeExpression.newOf(
                            storyClassRef,
                            [],
                            {
                              'name': refer('\$name').ifNullThen(
                                refer('name'),
                              ),
                              'setup': refer('setup'),
                              'args': refer('args'),
                              'argsBuilder': refer('argsBuilder'),
                              'scenariosViewport': refer('scenariosViewport'),
                              // We need to call `copyWith` on each scenario
                              // to ensure the back-reference gets uninitialized
                              // again in the scenarios instances, as it will
                              // get re-initialized in the new story instance.
                              'scenarios': refer('scenarios')
                                  .property('map')
                                  .call([
                                    Method(
                                      (b) =>
                                          b
                                            ..requiredParameters.add(
                                              Parameter(
                                                (b) => b.name = 'scenario',
                                              ),
                                            )
                                            ..body =
                                                refer('scenario')
                                                    .property('copyWith')
                                                    .call([])
                                                    .code,
                                    ).closure,
                                  ])
                                  .property('toList')
                                  .call([]),
                            },
                          ).code,
              ),
            ),
    );
  }

  InvokeExpression instantiate(
    Expression Function(FormalParameterElement) assigner,
  ) {
    return InvokeExpression.newOf(
      widgetType.getRef(),
      params //
          .where((param) => param.isPositional)
          .map(assigner)
          .toList(),
      params //
          .where((param) => param.isNamed)
          .lastBy((param) => param.displayName)
          .map(
            (_, param) => MapEntry(
              param.displayName,
              assigner(param),
            ),
          ),
    );
  }
}
