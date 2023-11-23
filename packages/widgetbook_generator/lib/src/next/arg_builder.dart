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
        ..toThis = true
        ..required = false
        ..defaultTo = InvokeExpression.constOf(
          refer('StringArg'),
          [],
          {'name': literalString(param.name)},
        ).code,
    );
  }

  Expression buildValue() {
    return refer(param.name)
        .property('valueFromQueryGroup')
        .call([refer('group')]);
  }
}
