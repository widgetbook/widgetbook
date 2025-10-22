import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';

import 'extensions.dart';

class ArgBuilder {
  ArgBuilder(this.param);

  final FormalParameterElement param;

  Field buildField() {
    return Field(
      (b) =>
          b
            ..modifier = FieldModifier.final$
            ..name = param.displayName
            ..type = TypeReference(
              (b) =>
                  b
                    ..symbol = 'Arg'
                    ..isNullable = param.type.isNullable
                    ..types.add(refer(param.type.getDisplayString())),
            ),
    );
  }

  Expression buildInitializer() {
    final defaultValue = buildDefaultValue();
    final caller = refer('\$initArg').call(
      [
        literalString(param.displayName),
        refer(param.displayName),
        defaultValue,
      ],
    );

    final hasValue =
        param.hasDefaultValue || param.type.isPrimitive || param.requiresArg;

    return hasValue ? caller.nullChecked : caller;
  }

  Expression buildDefaultValue() {
    // Non-primitive + no default
    if (!param.type.isPrimitive && !param.hasDefaultValue) {
      return literalNull;
    }

    // Non-primitive + default
    if (!param.type.isPrimitive) {
      return InvokeExpression.newOf(
        refer('ConstArg'),
        [refer(param.defaultValueCode!)],
      );
    }

    // Primitive + default / no default
    return InvokeExpression.newOf(
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
    );
  }

  Parameter buildArgParam() {
    return Parameter(
      (b) =>
          b
            ..named = true
            ..name = param.displayName
            ..required = param.requiresArg
            ..type = TypeReference(
              (b) =>
                  b
                    ..symbol = 'Arg'
                    ..isNullable = !param.requiresArg
                    ..types.add(refer(param.type.getDisplayString())),
            ),
    );
  }

  Parameter buildFixedParam() {
    return Parameter(
      (b) =>
          b
            ..named = true
            ..name = param.displayName
            ..type = TypeReference(
              (b) =>
                  b
                    ..symbol = param.type.nonNullableName
                    ..isNullable = param.type.isNullable,
            )
            ..required = param.requiresArg
            ..defaultTo =
                param
                        .hasDefaultValue //
                    ? refer(param.defaultValueCode!).code
                    : param.type.isPrimitive
                    ? param.type.meta.defaultValue.code
                    : null,
    );
  }
}
