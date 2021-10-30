import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';

@immutable

/// Defines a lambda function instance.
///
/// Example:
/// `(context) => buildStory(context)`
class LambdaInstance extends BaseInstance {
  /// Creates a new instance of [LambdaInstance]
  const LambdaInstance({
    required this.name,
    this.parameters = const <String>[],
  });

  /// The name of the function
  ///
  /// Example for `(context) => buildStory(context)`
  /// [name] would be `buildStory`
  final String name;

  /// The parameters of the function
  ///
  /// Example for `(context, index) => buildStory(context, index)`
  /// [parameters] would be `['context', 'index']`
  final List<String> parameters;

  /// Joins the parameters by inserting a ', ' between every instance
  ///
  /// Example:
  /// for the parameters `['context', 'index']`
  /// returns 'context, index'
  String _parametersToCode() {
    return parameters.join(', ');
  }

  @override
  String toCode() {
    final parameters = _parametersToCode();
    return '($parameters) => $name($parameters)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is LambdaInstance &&
        other.name == name &&
        listEquals(other.parameters, parameters);
  }

  @override
  int get hashCode => name.hashCode ^ parameters.hashCode;
}
