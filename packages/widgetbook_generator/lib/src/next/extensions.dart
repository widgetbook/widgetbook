import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

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
      refer('Colors').property('white'),
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
