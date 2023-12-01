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
        ..type = refer(
          'Arg<${param.type.displayName}>',
        ),
    );
  }

  Parameter buildArgParam() {
    return Parameter(
      (b) => b
        ..named = true
        ..name = param.name
        ..type = refer('Arg<${param.type.displayName}>')
        ..required = !param.type.isPrimitive
        ..defaultTo = !param.type.isPrimitive
            ? null
            : InvokeExpression.constOf(
                refer(param.type.meta.argName),
                [],
                {
                  'name': literalString(param.name),
                  if (param.hasDefaultValue)
                    'value': refer(param.defaultValueCode!),
                },
              ).code,
    );
  }

  Parameter buildFixedParam() {
    return Parameter(
      (b) => b
        ..named = true
        ..name = param.name
        ..type = refer(param.type.displayName)
        ..required = !param.type.isPrimitive
        ..defaultTo = !param.type.isPrimitive
            ? null
            : refer(param.type.meta.defaultValue).code,
    );
  }
}
