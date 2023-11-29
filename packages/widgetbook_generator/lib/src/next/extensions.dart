import 'package:analyzer/dart/element/type.dart';

extension DartTypeX on DartType {
  static final SupportedArgs = {
    'bool': 'BoolArg',
    'int': 'IntArg',
    'double': 'DoubleArg',
    'String': 'StringArg',
    'Color': 'ColorArg',
    'Duration': 'DurationArg',
  };

  String get displayName {
    return getDisplayString(withNullability: false);
  }

  bool get isPrimitive {
    return SupportedArgs.containsKey(displayName);
  }

  String get primitiveArg {
    return SupportedArgs[displayName]!;
  }
}
