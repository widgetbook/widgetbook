import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

import 'extensions.dart';

class StoryClassBuilder {
  StoryClassBuilder(
    this.widgetType,
    this.argsType,
    this.defaultSetup,
    this.defaultBuilder,
  );

  final DartType widgetType;
  final DartType argsType;
  final Code? defaultSetup;
  final Code? defaultBuilder;

  TypeReference get storyClassRef {
    return widgetType.getRef(
      suffix: 'Story',
      types: getTypeParams(withBounds: false),
    );
  }

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

  TypeDef buildUnderscoreType() {
    final classRef = storyClassRef;
    return TypeDef(
      (b) => b
        ..name = '_Story'
        ..types.addAll(getTypeParams())
        ..definition = TypeReference(
          (b) => b
            ..symbol = classRef.symbol
            ..types.addAll(classRef.types),
        ),
    );
  }

  Class build() {
    final isCustomArgs = widgetType != argsType;
    final hasRequiredArgs = params.any((param) => param.requiresArg);
    final unboundedTypeParams = getTypeParams(withBounds: false);

    final isGeneric = unboundedTypeParams.isNotEmpty;
    final hasBuilder = defaultBuilder != null;
    final hasSetup = defaultSetup != null;

    final widgetClassRef = widgetType.getRef();
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
      (b) => b
        ..name = storyClassRef.symbol
        ..types.addAll(getTypeParams())
        ..extend = TypeReference(
          (b) => b
            ..symbol = 'Story'
            ..types.addAll([widgetClassRef, argsClassRef]),
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
                    ..toSuper = !hasBuilder
                    ..type = !hasBuilder
                        ? null
                        : TypeReference(
                            (b) => b
                              ..symbol = 'SetupBuilder'
                              ..isNullable = true
                              ..types.addAll([
                                widgetClassRef,
                                argsClassRef,
                              ]),
                          ),
                ),
                Parameter(
                  (b) => b
                    ..name = 'modes'
                    ..named = true
                    ..toSuper = true,
                ),
                Parameter(
                  (b) => b
                    ..name = 'args'
                    ..named = true
                    ..toSuper = hasRequiredArgs
                    ..required = hasRequiredArgs
                    ..type = hasRequiredArgs ? null : nullableArgsClassRef,
                ),
                Parameter(
                  (b) => b
                    ..name = 'builder'
                    ..named = true
                    ..toSuper = isCustomArgs && !hasBuilder
                    ..required = isCustomArgs && !hasBuilder
                    ..type = isCustomArgs && !hasBuilder
                        ? null
                        : TypeReference(
                            (b) => b
                              ..symbol = 'StoryWidgetBuilder'
                              ..isNullable = true
                              ..types.addAll([
                                widgetClassRef,
                                argsClassRef,
                              ]),
                          ),
                ),
                Parameter(
                  (b) => b
                    ..name = 'scenarios'
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
                if (!isCustomArgs && !hasBuilder)
                  'builder': refer('builder').ifNullThen(
                    Method(
                      (b) => b
                        ..lambda = true
                        ..requiredParameters.addAll([
                          Parameter((b) => b.name = 'context'),
                          Parameter((b) => b.name = 'args'),
                        ])
                        ..body = instantiate(
                          (param) => refer(
                            'args',
                          ).property(param.displayName),
                        ).code,
                    ).closure,
                  ),
                // In case the Story has generic type parameters, we need to
                // to copy the actual builder/setup functions from the defaults
                // to preserve the type arguments.
                // For a Story<int>, we cannot use Defaults<num>'s setup/builder
                // as they expect num, not int. Casting a subtype to a supertype
                // is not allowed in Dart.
                // On the other hand, we just pipe the builder/setup from defaults
                // to Story, in case the Story is not generic. This is a better
                // DX since users do not to re-run the build_runner when changing
                // the defaults.
                if (hasBuilder)
                  'builder': refer('builder').ifNullThen(
                    isGeneric
                        ? CodeExpression(defaultBuilder!)
                        : refer('defaults').property('builder').nullChecked,
                  ),
                if (hasSetup)
                  'setup': refer('setup').ifNullThen(
                    isGeneric
                        ? CodeExpression(defaultSetup!)
                        : refer('defaults').property('setup').nullChecked,
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
