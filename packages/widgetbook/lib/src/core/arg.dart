import 'package:flutter/widgets.dart';

import '../fields/fields.dart';
import '../state/state.dart';
import 'const_arg.dart';

@optionalTypeArgs
abstract class Arg<T> extends FieldsComposable<T> {
  const Arg(
    T value, {
    String? name,
  }) : $value = value,
       $name = name,
       super(name: name ?? '');

  const Arg.empty() : $value = null, $name = null, super(name: '');

  final T? $value;
  final String? $name;

  T get value => $value!;

  String get name {
    // A safe way to access [$name] in a non-nullable behavior for simplicity.
    // The name should ne provided via constructor or init method.
    assert(
      $name != null,
      'Name must be set via constructor or init method',
    );

    return $name!;
  }

  @override
  String get groupName => name;

  /// Creates a copy of this using the provided [name] for late initialization.
  /// If [$name] was already set, it should have precedence over [name].
  ///
  /// Example:
  /// Arg(0).init(name: 'integer') => Arg(0, name: 'integer')
  /// Arg(0, name: 'int').init(name: 'integer') => Arg(0, name: 'int')
  Arg<T> init({
    required String name,
  });

  static ConstArg<T> fixed<T>(T value) => ConstArg<T>(value);

  /// Resolves the value of this argument based on the current context.
  /// If there is no [WidgetbookState] in the widget tree, it returns the
  /// default [value].
  T resolve(BuildContext context) {
    final state = WidgetbookState.maybeOf(context);
    if (state == null) return value;

    final queryGroup = FieldCodec.decodeQueryGroup(
      state.queryParams[groupName],
    );

    return valueFromQueryGroup(queryGroup);
  }

  Map<String, String> toQueryGroup() {
    return $value == null ? {} : valueToQueryGroup(value);
  }
}
