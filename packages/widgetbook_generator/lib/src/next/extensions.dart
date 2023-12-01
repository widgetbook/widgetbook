import 'package:analyzer/dart/element/type.dart';

extension DartTypeX on DartType {
  static final typesMeta = {
    'bool': TypeMeta('BoolArg', 'false'),
    'int': TypeMeta('IntArg', '0'),
    'double': TypeMeta('DoubleArg', '0.0'),
    'String': TypeMeta('StringArg', '""'),
    'Color': TypeMeta('ColorArg', 'Colors.white'),
    'Duration': TypeMeta('DurationArg', 'Duration.zero'),
  };

  String get displayName {
    return getDisplayString(withNullability: false);
  }

  bool get isPrimitive {
    return typesMeta.containsKey(displayName);
  }

  TypeMeta get meta {
    return typesMeta[displayName]!;
  }
}

class TypeMeta {
  TypeMeta(this.argName, this.defaultValue);

  final String argName;
  final String defaultValue;
}
