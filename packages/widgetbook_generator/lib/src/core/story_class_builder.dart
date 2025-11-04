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
    this.hasBuilder,
  );

  final DartType widgetType;
  final DartType argsType;
  final bool hasSetup;
  final bool hasBuilder;

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
                            ..toSuper = !hasBuilder
                            ..type =
                                !hasBuilder
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
                            ..name = 'modes'
                            ..named = true
                            ..toSuper = true,
                    ),
                    Parameter(
                      (b) =>
                          b
                            ..name = 'args'
                            ..named = true
                            ..toSuper = hasRequiredArgs
                            ..required = hasRequiredArgs
                            ..type =
                                hasRequiredArgs
                                    ? null
                                    : TypeReference(
                                      (b) =>
                                          b
                                            ..symbol = 'ArgsBuilder'
                                            ..isNullable = true
                                            ..types.addAll([argsClassRef]),
                                    ),
                    ),
                    Parameter(
                      (b) =>
                          b
                            ..name = 'builder'
                            ..named = true
                            ..toSuper = isCustomArgs && !hasBuilder
                            ..required = isCustomArgs && !hasBuilder
                            ..type =
                                isCustomArgs && !hasBuilder
                                    ? null
                                    : TypeReference(
                                      (b) =>
                                          b
                                            ..symbol = 'StoryWidgetBuilder'
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
                  ]);

                  final superInitializers = {
                    if (!hasRequiredArgs)
                      'args': refer('args').ifNullThen(
                        Method(
                          (b) =>
                              b
                                ..lambda = true
                                ..requiredParameters.add(
                                  Parameter((b) => b.name = 'context'),
                                )
                                ..body =
                                    InvokeExpression.newOf(
                                      argsClassRef,
                                      [],
                                    ).code,
                        ).closure,
                      ),
                    if (!isCustomArgs && !hasBuilder)
                      'builder': refer('builder').ifNullThen(
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
                                      (param) => refer(
                                        'args',
                                      ).property(param.displayName),
                                    ).code,
                        ).closure,
                      ),
                    if (hasBuilder)
                      'builder': refer('builder').ifNullThen(
                        refer('\$builder'),
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
