import 'package:code_builder/code_builder.dart';

import 'arg_builder.dart';
import 'extensions.dart';
import 'variant.dart';

class ArgsClassBuilder {
  ArgsClassBuilder(this.variant);

  final Variant variant;

  TypeReference get argsClassRef {
    return variant.argsType.getRef(
      suffix: variant.argsSuffix,
      types: variant.getTypeParams(withBounds: false),
    );
  }

  TypeDef buildUnderscoreType() {
    final classRef = argsClassRef;
    return TypeDef(
      (b) => b
        ..name = '_${variant.prefix}Args'
        ..types.addAll(variant.getTypeParams())
        ..definition = TypeReference(
          (b) => b
            ..symbol = classRef.symbol
            ..types.addAll(classRef.types),
        ),
    );
  }

  Class build() {
    final params = variant.params;
    final widgetClassRef = variant.widgetType.getRef();

    return Class(
      (b) => b
        ..name = argsClassRef.symbol
        ..types.addAll(variant.getTypeParams())
        ..extend = TypeReference(
          (b) => b
            ..symbol = 'StoryArgs'
            ..types.addAll([widgetClassRef]),
        )
        ..fields.addAll(
          params.map(
            (param) => ArgBuilder(param).buildField(),
          ),
        )
        ..constructors.addAll([
          Constructor(
            (b) => b
              ..optionalParameters.addAll(
                params.map(
                  (param) => ArgBuilder(param).buildArgParam(),
                ),
              )
              ..initializers.addAll(
                params.map(
                  (param) => refer('this')
                      .property('${param.displayName}Arg')
                      .assign(
                        ArgBuilder(param).buildInitializer(),
                      )
                      .code,
                ),
              ),
          ),
          Constructor(
            (b) => b
              ..name = 'fixed'
              ..optionalParameters.addAll(
                params.map(
                  (param) => ArgBuilder(param).buildFixedParam(),
                ),
              )
              ..initializers.addAll(
                params.map(
                  (param) => refer('this')
                      .property('${param.displayName}Arg')
                      .assign(
                        param.type.isNullable
                            ? refer(param.displayName)
                                  .equalTo(literalNull)
                                  .conditional(
                                    literalNull,
                                    InvokeExpression.newOf(
                                      refer('Arg.fixed'),
                                      [refer(param.displayName)],
                                    ),
                                  )
                            : InvokeExpression.newOf(
                                refer('Arg.fixed'),
                                switch (param) {
                                  // For non-constant value, like DateTime.now()
                                  // they are initialized here instead of the
                                  // default value of the parameter
                                  _
                                      when param.type.isPrimitive &&
                                          !param.type.meta.isConst =>
                                    [
                                      refer(
                                        param.displayName,
                                      ).ifNullThen(
                                        param.type.meta.defaultValue,
                                      ),
                                    ],
                                  _ => [refer(param.displayName)],
                                },
                              ),
                      )
                      .code,
                ),
              ),
          ),
        ])
        ..methods.addAll([
          ...params.map(
            (param) => Method(
              (b) => b
                ..name = param.displayName
                ..type = MethodType.getter
                ..returns = TypeReference(
                  (b) => b
                    ..symbol = param.type.nonNullableName
                    ..isNullable = param.type.isNullable,
                )
                ..lambda = true
                ..body =
                    refer(
                          '${param.displayName}Arg',
                        )
                        .maybeProperty(
                          'value',
                          nullSafe: param.type.isNullable,
                        )
                        .code,
            ),
          ),

          Method(
            (b) => b
              ..name = 'list'
              ..type = MethodType.getter
              ..returns = TypeReference(
                (b) => b
                  ..symbol = 'List'
                  ..types.add(
                    TypeReference(
                      (b) => b
                        ..symbol = 'Arg'
                        ..isNullable = true,
                    ),
                  ),
              )
              ..annotations.add(refer('override'))
              ..lambda = true
              ..body = literalList(
                params.map(
                  (param) => refer('${param.displayName}Arg'),
                ),
              ).code,
          ),
        ]),
    );
  }
}
