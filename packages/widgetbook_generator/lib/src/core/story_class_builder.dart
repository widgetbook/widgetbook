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

  Iterable<ParameterElement> get params {
    return (argsType.element as ClassElement).constructors.first.parameters;
  }

  Class build() {
    final isCustomArgs = widgetType != argsType;
    final hasRequiredArgs = params.any((param) => param.requiresArg);

    return Class(
      (b) => b
        ..name = '${widgetType.nonNullableName}Story'
        ..extend = TypeReference(
          (b) => b
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
                  (b) => b
                    ..name = 'name'
                    ..named = true
                    ..toSuper = true,
                ),
                Parameter(
                  (b) => b
                    ..name = 'setup'
                    ..named = true
                    ..toSuper = true
                    ..defaultTo = hasSetup ? refer('setup').code : null,
                ),
                Parameter(
                  (b) => b
                    ..name = 'args'
                    ..named = true
                    ..toSuper = hasRequiredArgs
                    ..required = hasRequiredArgs
                    ..type = hasRequiredArgs
                        ? null
                        : refer('${argsType.nonNullableName}Args?'),
                ),
                Parameter(
                  (b) => b
                    ..name = 'argsBuilder'
                    ..named = true
                    ..toSuper = isCustomArgs
                    ..defaultTo =
                        hasArgsBuilder ? refer('argsBuilder').code : null
                    ..required = isCustomArgs && !hasArgsBuilder
                    ..type = isCustomArgs
                        ? null
                        : TypeReference(
                            (b) => b
                              ..symbol = 'ArgsBuilder'
                              ..isNullable = true
                              ..types.addAll([
                                refer(widgetType.nonNullableName),
                                refer('${argsType.nonNullableName}Args'),
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
                      (b) => b
                        ..lambda = true
                        ..requiredParameters.addAll([
                          Parameter((b) => b.name = 'context'),
                          Parameter((b) => b.name = 'args'),
                        ])
                        ..body = instantiate(
                          (param) => refer('args') //
                              .property(param.name)
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
                  refer('super').call(
                    [],
                    superInitializers,
                  ).code,
                );
              }
            },
          ),
        )
        ..methods.add(
          Method(
            (b) => b
              ..name = 'init'
              ..annotations.add(refer('override'))
              ..optionalParameters.add(
                Parameter(
                  (b) => b
                    ..name = 'name'
                    ..named = true
                    ..required = true
                    ..type = refer('String'),
                ),
              )
              ..returns = refer(
                '${widgetType.nonNullableName}Story',
              )
              ..lambda = true
              ..body = InvokeExpression.newOf(
                refer('${widgetType.nonNullableName}Story'),
                [],
                {
                  'name': refer('this').property('\$name').ifNullThen(
                        refer('name'),
                      ),
                  'setup': refer('this').property('setup'),
                  'args': refer('this').property('args'),
                  'argsBuilder': refer('this').property('argsBuilder'),
                },
              ).code,
          ),
        ),
    );
  }

  InvokeExpression instantiate(
    Expression Function(ParameterElement) assigner,
  ) {
    return InvokeExpression.newOf(
      refer(widgetType.nonNullableName),
      params //
          .where((param) => param.isPositional)
          .map(assigner)
          .toList(),
      params //
          .where((param) => param.isNamed)
          .lastBy((param) => param.name)
          .map(
            (_, param) => MapEntry(
              param.name,
              assigner(param),
            ),
          ),
    );
  }
}
