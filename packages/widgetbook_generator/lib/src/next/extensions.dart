import 'package:analyzer/dart/element/type.dart';

extension DartTypeX on DartType {
  static final supportedArgs = {
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
    return supportedArgs.containsKey(displayName);
  }

  String get primitiveArg {
    return supportedArgs[displayName]!;
  }
}
