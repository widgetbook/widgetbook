// ignore_for_file: deprecated_member_use analyzer(<8.0.0)

import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

import 'extensions.dart';

class StoryClassBuilder {
  StoryClassBuilder(
    this.widgetType,
    this.argsType,
  );

  final DartType widgetType;
  final DartType argsType;

  Iterable<FormalParameterElement> get params {
    return (argsType.element3 as ClassElement2)
        .constructors2
        .first
        .formalParameters;
  }

  Class build() {
    final isCustomArgs = widgetType != argsType;
    final hasRequiredArgs = params.any((param) => param.requiresArg);

    return Class(
      (b) =>
          b
            ..name = '${widgetType.nonNullableName}Story'
            ..extend = TypeReference(
              (b) =>
                  b
                    ..symbol = 'Story'
                    ..types.addAll([
                      refer(widgetType.nonNullableName),
                      refer('${argsType.nonNullableName}Args'),
                    ]),
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
                            ..toSuper = true
                            ..required = true,
                    ),
                    Parameter(
                      (b) =>
                          b
                            ..name = 'setup'
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
                                    : refer('${argsType.nonNullableName}Args?'),
                    ),
                    Parameter(
                      (b) =>
                          b
                            ..name = 'argsBuilder'
                            ..named = true
                            ..toSuper = isCustomArgs
                            ..required = isCustomArgs
                            ..type =
                                isCustomArgs
                                    ? null
                                    : TypeReference(
                                      (b) =>
                                          b
                                            ..symbol = 'ArgsBuilder'
                                            ..isNullable = true
                                            ..types.addAll([
                                              refer(widgetType.nonNullableName),
                                              refer(
                                                '${argsType.nonNullableName}Args',
                                              ),
                                            ]),
                                    ),
                    ),
                  ]);

                  final superInitializers = {
                    if (!hasRequiredArgs)
                      'args': refer('args').ifNullThen(
                        refer('${argsType.nonNullableName}Args()'),
                      ),
                    if (!isCustomArgs)
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
      refer(widgetType.nonNullableName),
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
