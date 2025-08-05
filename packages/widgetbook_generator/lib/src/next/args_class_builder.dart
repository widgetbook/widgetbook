import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

import 'arg_builder.dart';
import 'extensions.dart';

class ArgsClassBuilder {
  ArgsClassBuilder(this.widgetType, this.argsType);

  final DartType widgetType;
  final DartType argsType;

  Iterable<FormalParameterElement> get params {
    return (argsType.element3 as ClassElement2)
        .constructors2
        .first
        .formalParameters;
  }

  Class build() {
    return Class(
      (b) =>
          b
            ..name = '${argsType.nonNullableName}Args'
            ..extend = TypeReference(
              (b) =>
                  b
                    ..symbol = 'StoryArgs'
                    ..types.addAll([
                      refer(widgetType.nonNullableName),
                    ]),
            )
            ..fields.addAll(
              params.map(
                (param) => ArgBuilder(param).buildField(),
              ),
            )
            ..constructors.addAll([
              Constructor(
                (b) =>
                    b
                      ..optionalParameters.addAll(
                        params.map(
                          (param) => ArgBuilder(param).buildArgParam(),
                        ),
                      )
                      ..initializers.addAll(
                        params.map(
                          (param) =>
                              refer('this')
                                  .property(param.displayName)
                                  .assign(
                                    refer(param.displayName)
                                        .maybeProperty(
                                          'init',
                                          nullSafe: param.type.isNullable,
                                        )
                                        .call([], {
                                          'name': literalString(
                                            param.displayName,
                                          ),
                                        }),
                                  )
                                  .code,
                        ),
                      ),
              ),
              Constructor(
                (b) =>
                    b
                      ..name = 'fixed'
                      ..optionalParameters.addAll(
                        params.map(
                          (param) => ArgBuilder(param).buildFixedParam(),
                        ),
                      )
                      ..initializers.addAll(
                        params.map(
                          (param) =>
                              refer('this')
                                  .property(param.displayName)
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
                                          [refer(param.displayName)],
                                        ),
                                  )
                                  .code,
                        ),
                      ),
              ),
            ])
            ..methods.add(
              Method(
                (b) =>
                    b
                      ..name = 'list'
                      ..type = MethodType.getter
                      ..returns = TypeReference(
                        (b) =>
                            b
                              ..symbol = 'List'
                              ..types.add(
                                TypeReference(
                                  (b) =>
                                      b
                                        ..symbol = 'Arg'
                                        ..isNullable = true,
                                ),
                              ),
                      )
                      ..annotations.add(refer('override'))
                      ..lambda = true
                      ..body =
                          literalList(
                            params.map(
                              (param) => refer(param.displayName),
                            ),
                          ).code,
              ),
            ),
    );
  }
}
