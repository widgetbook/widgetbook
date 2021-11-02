import 'package:meta/meta.dart';
import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';

@immutable

/// Calls a function.
///
/// Example:
/// for a lambda function defined as `() => getTheme()`
/// would call it as `getTheme()`
class FunctionCallInstance extends BaseInstance {
  /// Create a new instace of [FunctionCallInstance]
  const FunctionCallInstance({
    required this.name,
  });

  /// The name of the function
  final String name;

  @override
  String toCode() {
    return '$name()';
  }
}
