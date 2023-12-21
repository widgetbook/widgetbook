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

  String get nonNullableName {
    // We get the display string with nullability then we remove the trailing
    // "?" if it exists, to avoid this issue with function and generic types:
    // 1. Function Types:
    //    - Type                : void Function(bool?)?
    //    - With nullability    : void Function(bool?)?
    //    - Without nullability : void Function(bool)
    //    - Expected            : void Function(bool?)
    // 2. Generics:
    //    - Type                : Future<bool?>?
    //    - With nullability    : Future<bool?>?
    //    - Without nullability : Future<bool>
    //    - Expected            : Future<bool?>

    final displayString = getDisplayString(
      withNullability: true,
    );

    return nullabilitySuffix != NullabilitySuffix.none
        ? displayString.substring(0, displayString.length - 1)
        : displayString;
  }

  bool get isPrimitive {
    return isEnum || typesMeta.containsKey(nonNullableName);
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
            'EnumArg<$nonNullableName>',
            refer(nonNullableName).property(
              (element as EnumElement).fields.first.name,
            ),
          )
        : typesMeta[nonNullableName]!;
  }
}

class TypeMeta {
  TypeMeta(this.argName, this.defaultValue);

  final String argName;
  final Expression defaultValue;
}
