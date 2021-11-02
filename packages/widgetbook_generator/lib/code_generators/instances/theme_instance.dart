import 'package:widgetbook_generator/code_generators/instances/function_call_instance.dart';

/// An instance of a function returning ThemeData
///
/// Since ThemeData is always returned as a function, [ThemeInstance] is based
/// on [FunctionCallInstance]
class ThemeInstance extends FunctionCallInstance {
  /// Creates a new instance of [ThemeInstance]
  const ThemeInstance({
    required String name,
  }) : super(
          name: name,
        );
}
