import 'package:flutter/widgets.dart';

import '../fields/fields.dart';
import '../state/state.dart';
import 'arg.dart';
import 'story.dart';

/// [Addon]s are like global [Arg]s, they change the state for all
/// [Story]s. For example, you can manipulate the theme for all
/// [Story]s, instead of doing it one-by-one using [Arg]s.
@optionalTypeArgs
abstract class Addon<T> extends FieldsComposable<T> {
  Addon({
    required super.name,
  });

  @override
  String get groupName => slugify(name);

  Widget build(BuildContext context, Widget child) {
    final state = WidgetbookState.of(context);
    final groupMap = FieldCodec.decodeQueryGroup(
      state.queryParams[groupName],
    );

    final newSetting = valueFromQueryGroup(groupMap);

    return buildUseCase(
      context,
      child,
      newSetting,
    );
  }

  /// Wraps use cases with a custom widget depending on the addon [setting]
  /// that is obtained from [valueFromQueryGroup].
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    T setting,
  ) {
    return child;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'group': groupName,
      'fields': fields.map((field) => field.toFullJson()).toList(),
    };
  }
}
