import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';

import 'extensions.dart';

class ArgBuilder {
  ArgBuilder(this.param);

  final ParameterElement param;

  Field buildField() {
    return Field(
      (b) => b
        ..modifier = FieldModifier.final$
        ..name = param.name
        ..type = TypeReference(
          (b) => b
            ..symbol = 'Arg'
            ..isNullable = param.type.isNullable
            ..types.add(refer(param.type.nonNullableName)),
        ),
    );
  }

  Parameter buildArgParam() {
    return Parameter(
      (b) => b
        ..named = true
        ..name = param.name
        ..type = TypeReference(
          (b) => b
            ..symbol = 'Arg'
            ..isNullable = param.type.isNullable
            ..types.add(refer(param.type.nonNullableName)),
        )
        ..required = param.requiresArg
        ..defaultTo = !param.type.isPrimitive
            ? param.hasDefaultValue
                ? InvokeExpression.constOf(
                    refer('ConstArg'),
                    [refer(param.defaultValueCode!)],
                  ).code
                : null
            : InvokeExpression.constOf(
                refer(param.type.meta.argName),
                param.hasDefaultValue
                    ? [refer(param.defaultValueCode!)]
                    : [param.type.meta.defaultValue],
                {
                  if (param.type.isEnum)
                    'values': refer(
                      param.type.nonNullableName,
                    ).property('values'),
                },
              ).code,
    );
  }

  Parameter buildFixedParam() {
    return Parameter(
      (b) => b
        ..named = true
        ..name = param.name
        ..type = TypeReference(
          (b) => b
            ..symbol = param.type.nonNullableName
            ..isNullable = param.type.isNullable,
        )
        ..required = param.requiresArg
        ..defaultTo = param.hasDefaultValue //
            ? refer(param.defaultValueCode!).code
            : param.type.isPrimitive
                ? param.type.meta.defaultValue.code
                : null,
    );
  }
}
