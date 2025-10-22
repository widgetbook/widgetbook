import 'package:flutter/widgets.dart';

import '../fields/fields.dart';
import '../routing/routing.dart';
import '../state/state.dart';
import 'const_arg.dart';

/// Used to initialize an [Arg] with either a default value or a user-provided
/// value.
/// If both [defaultArg] and [userArg] are null, it returns null.
Arg<T>? $initArg<T>(
  String name,
  Arg<T>? userArg,
  Arg<T>? defaultArg,
) {
  if (userArg == null && defaultArg == null) return null;

  final arg = userArg ?? defaultArg;
  return arg!..$generatedName = name;
}

@optionalTypeArgs
abstract class Arg<T> extends FieldsComposable<T> {
  Arg(
    this.value, {
    String? name,
  }) : _name = name,
       super(
         name: name ?? '',
         initialValue: value,
       );

  final T value;

  final String? _name;
  late final String $generatedName;

  @override
  String get name => _name ?? $generatedName;

  @override
  String get groupName => name;

  static ConstArg<T> fixed<T>(T value) => ConstArg<T>(value);

  /// Resolves the value of this argument based on the current context.
  /// If there is no [WidgetbookState] in the widget tree, it returns the
  /// default [value].
  T resolve(BuildContext context) {
    final state = WidgetbookState.maybeOf(context);
    final group = state?.queryGroups[groupName];

    if (group == null) return value;

    return valueFromQueryGroup(group);
  }

  QueryGroup? toQueryGroup() {
    // Since this method is used only in `widgetbook_test` to serialize
    // the args, we return null if the value is null to avoid unnecessary
    // query groups.
    return value == null ? null : valueToQueryGroup(value);
  }
}
