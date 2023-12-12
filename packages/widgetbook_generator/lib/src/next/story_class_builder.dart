import 'package:analyzer/dart/element/element.dart';
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

  Iterable<ParameterElement> get params {
    return (argsType.element as ClassElement)
        .constructors
        .first
        .parameters
        .whereNot((param) => param.name == 'key');
  }

  Class build() {
    final isPrimitiveArgs = params.every((param) => param.type.isPrimitive);
    final isCustomArgs = widgetType != argsType;

    return Class(
      (b) => b
        ..name = '${widgetType.displayName}Story'
        ..extend = TypeReference(
          (b) => b
            ..symbol = 'Story'
            ..types.addAll([
              refer(widgetType.displayName),
              refer('${argsType.displayName}Args'),
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
                    ..toSuper = true
                    ..required = true,
                ),
                Parameter(
                  (b) => b
                    ..name = 'args'
                    ..named = true
                    ..toSuper = !isPrimitiveArgs
                    ..required = !isPrimitiveArgs
                    ..type = !isPrimitiveArgs
                        ? null
                        : refer('${argsType.displayName}Args?'),
                ),
                Parameter(
                  (b) => b
                    ..name = 'setup'
                    ..named = true
                    ..toSuper = true,
                ),
                if (isCustomArgs)
                  Parameter(
                    (b) => b
                      ..name = 'argsBuilder'
                      ..named = true
                      ..toSuper = true
                      ..required = true,
                  ),
              ]);

              final superInitializers = {
                if (isPrimitiveArgs)
                  'args': refer('args').ifNullThen(
                    refer('${argsType.displayName}Args()'),
                  ),
                if (!isCustomArgs)
                  'argsBuilder': Method(
                    (b) => b
                      ..lambda = true
                      ..requiredParameters.addAll([
                        Parameter((b) => b.name = 'context'),
                        Parameter((b) => b.name = 'args'),
                      ])
                      ..body = instantiate(
                        (param) => refer('args') //
                            .property(param.name)
                            .property('resolve')
                            .call([refer('context')]),
                      ).code,
                  ).closure,
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
        ),
    );
  }

  InvokeExpression instantiate(
    Expression Function(ParameterElement) assigner,
  ) {
    return InvokeExpression.newOf(
      refer(widgetType.displayName),
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
