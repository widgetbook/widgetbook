import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';

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
          'WidgetbookArg<${param.type.getDisplayString(
            withNullability: false,
          )}>',
        ),
    );
  }

  Parameter buildParam() {
    return Parameter(
      (b) => b
        ..named = true
        ..name = param.name
        ..type = refer('WidgetbookArg<${param.type.getDisplayString(
          withNullability: false,
        )}>')
        ..required = false
        ..defaultTo = InvokeExpression.constOf(
          refer(
            SupportedArgs[param.type.getDisplayString(
              withNullability: false,
            )]!,
          ),
          [],
          {'name': literalString(param.name)},
        ).code,
    );
  }
}
