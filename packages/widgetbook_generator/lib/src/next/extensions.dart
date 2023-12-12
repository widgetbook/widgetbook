import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

extension ExpressionX on Expression {
  Expression maybeProperty(
    String name, {
    required bool nullSafe,
  }) {
    return nullSafe ? this.nullSafeProperty(name) : this.property(name);
  }
}

extension ParameterElementX on ParameterElement {
  bool get requiresArg {
    return !type.isPrimitive && !type.isNullable && !hasDefaultValue;
  }
}

extension DartTypeX on DartType {
  static final typesMeta = {
    'bool': TypeMeta(
      'BoolArg',
      literalFalse,
    ),
    'int': TypeMeta(
      'IntArg',
      literalNum(0),
    ),
    'double': TypeMeta(
      'DoubleArg',
      literalNum(0.0),
    ),
    'String': TypeMeta(
      'StringArg',
      literalString(''),
    ),
    'Color': TypeMeta(
      'ColorArg',
      InvokeExpression.constOf(
        refer('Color'),
        [literalNum(0xFF000000)],
      ),
    ),
    'Duration': TypeMeta(
      'DurationArg',
      refer('Duration').property('zero'),
    ),
  };

  String get displayName {
    return getDisplayString(withNullability: false);
  }

  bool get isPrimitive {
    return isEnum || typesMeta.containsKey(displayName);
  }

  bool get isNullable {
    return nullabilitySuffix == NullabilitySuffix.question;
  }

  bool get isEnum {
    return element is EnumElement;
  }

  TypeMeta get meta {
    return isEnum
        ? TypeMeta(
            'EnumArg<$displayName>',
            refer(displayName).property(
              (element as EnumElement).fields.first.name,
            ),
          )
        : typesMeta[displayName]!;
  }
}

class TypeMeta {
  TypeMeta(this.argName, this.defaultValue);

  final String argName;
  final Expression defaultValue;
}
