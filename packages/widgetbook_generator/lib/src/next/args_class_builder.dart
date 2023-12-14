import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

import 'arg_builder.dart';
import 'extensions.dart';

class ArgsClassBuilder {
  ArgsClassBuilder(this.widgetType, this.argsType);

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
    return Class(
      (b) => b
        ..name = '${argsType.nonNullableName}Args'
        ..extend = TypeReference(
          (b) => b
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
            (b) => b
              ..optionalParameters.addAll(
                params.map(
                  (param) => ArgBuilder(param).buildArgParam(),
                ),
              )
              ..initializers.addAll(
                params.map(
                  (param) => refer('this')
                      .property(param.name)
                      .assign(
                        refer(param.name)
                            .maybeProperty(
                          'init',
                          nullSafe: param.type.isNullable,
                        )
                            .call([], {'name': literalString(param.name)}),
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
                      .property(param.name)
                      .assign(
                        param.type.isNullable
                            ? refer(param.name)
                                .equalTo(literalNull)
                                .conditional(
                                  literalNull,
                                  InvokeExpression.newOf(
                                    refer('Arg.fixed'),
                                    [refer(param.name)],
                                  ),
                                )
                            : InvokeExpression.newOf(
                                refer('Arg.fixed'),
                                [refer(param.name)],
                              ),
                      )
                      .code,
                ),
              ),
          ),
        ])
        ..methods.add(
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
                  (param) => refer(param.name),
                ),
              ).code,
          ),
        ),
    );
  }
}
