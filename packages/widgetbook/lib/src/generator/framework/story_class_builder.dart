import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

import 'extensions.dart';
import 'variant.dart';

class StoryClassBuilder {
  StoryClassBuilder(
    this.variant,
    this.defaultSetup,
    this.defaultBuilder,
    this.defaultsVariableName,
  );

  final Variant variant;
  final Code? defaultSetup;
  final Code? defaultBuilder;

  /// The name of the top-level variable holding the variant's `Defaults`,
  /// used to pipe its setup/builder into the generated story class.
  final String? defaultsVariableName;

  TypeReference get storyClassRef {
    return variant.widgetType.getRef(
      suffix: '${variant.prefix}Story',
      types: variant.getTypeParams(withBounds: false),
    );
  }

  TypeDef buildUnderscoreType() {
    final classRef = storyClassRef;
    return TypeDef(
      (b) => b
        ..name = '_${variant.prefix}Story'
        ..types.addAll(variant.getTypeParams())
        ..definition = TypeReference(
          (b) => b
            ..symbol = classRef.symbol
            ..types.addAll(classRef.types),
        ),
    );
  }

  Class build() {
    final isCustomArgs = variant.isCustomArgs;
    final hasRequiredArgs = variant.params.any((param) => param.requiresArg);
    final unboundedTypeParams = variant.getTypeParams(withBounds: false);

    final isGeneric = unboundedTypeParams.isNotEmpty;
    final hasBuilder = defaultBuilder != null;
    final hasSetup = defaultSetup != null;

    final widgetClassRef = variant.widgetType.getRef();
    final argsClassRef = variant.argsType.getRef(
      suffix: variant.argsSuffix,
      types: unboundedTypeParams,
    );

    final nullableArgsClassRef = variant.argsType.getRef(
      suffix: variant.argsSuffix,
      types: unboundedTypeParams,
      isNullable: true,
    );

    return Class(
      (b) => b
        ..name = storyClassRef.symbol
        ..types.addAll(variant.getTypeParams())
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
                    ..toSuper = !hasSetup
                    ..type = !hasSetup
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
                        : refer(
                            defaultsVariableName!,
                          ).property('builder').nullChecked,
                  ),
                if (hasSetup)
                  'setup': refer('setup').ifNullThen(
                    isGeneric
                        ? CodeExpression(defaultSetup!)
                        : refer(
                            defaultsVariableName!,
                          ).property('setup').nullChecked,
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
    final params = variant.params;

    return InvokeExpression.newOf(
      variant.widgetType.getRef(),
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
      const [],
      variant.constructorName,
    );
  }
}
