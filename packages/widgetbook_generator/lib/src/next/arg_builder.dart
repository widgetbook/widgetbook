import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';

import 'extensions.dart';

class ArgBuilder {
  ArgBuilder(this.param);

  final ParameterElement param;

  static final SupportedArgs = {
    '$String': 'StringArg',
  };

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

  Parameter buildParam() {
    return Parameter(
      (b) => b
        ..named = true
        ..name = param.name
        ..type = refer('Arg<${param.type.displayName}>')
        ..required = false
        ..defaultTo = InvokeExpression.constOf(
          refer(
            SupportedArgs[param.type.displayName]!,
          ),
          [],
          {'name': literalString(param.name)},
        ).code,
    );
  }
}
