import 'package:meta/meta.dart';
import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';
import 'package:widgetbook_generator/code_generators/parameters/parameter_list.dart';

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
    this.parameters = const ParameterList(),
  });

  /// The name of the function
  final String name;

  final ParameterList parameters;

  @override
  String toCode() {
    return '$name${parameters.toCode()}';
  }
}
