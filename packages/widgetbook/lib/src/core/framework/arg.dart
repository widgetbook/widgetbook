import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

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

  // In order to make this constructor, we had to make [value] late.
  // and FieldsComposable's initialValue late as well.
  // This is needed for the [BuilderArg] which can be empty.
  @internal
  Arg.empty() : _name = null, super.empty();

  // TODO: Revisit the decision before stable release
  // We had two option to make sure that the `value` is always in sync with
  // the query parameters:
  // 1. Immutable option with `copyWith` method: Decided against it because
  //    it would require more boilerplate when implementing custom Args.
  // 2. Mutable option with `syncValue` method.
  late T value; // `late` is added to allow `empty` constructor for BuilderArg

  final String? _name;
  late final String $generatedName;

  @override
  String get name => _name ?? $generatedName;

  @override
  String get groupName => name;

  static ConstArg<T> fixed<T>(T value) => ConstArg<T>(value);

  @internal
  void syncValue(QueryGroup? group) {
    value = valueFromQueryGroup(group);
  }

  @internal
  void resetValue() {
    value = initialValue;
  }

  void update(BuildContext context, T newValue) {
    final newGroup = valueToQueryGroup(newValue);

    // Avoid updates in tests where there is no WidgetbookState
    final state = WidgetbookState.maybeOf(context);
    state?.updateQueryGroup(groupName, newGroup);
  }

  QueryGroup? toQueryGroup() {
    // Since this method is used only in `widgetbook_test` to serialize
    // the args, we return null if the value is null to avoid unnecessary
    // query groups.
    return value == null ? null : valueToQueryGroup(value);
  }
}

/// An [Arg] that is associated with a style to define its UI representation.
abstract class StyledArg<T, TStyle> extends Arg<T> {
  StyledArg(
    super.value, {
    super.name,
    required this.style,
  });

  final TStyle style;
}
