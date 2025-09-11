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
  /// Creates an [Addon] with the given [name].
  Addon({
    required super.name,
  });

  @override
  String get groupName => slugify(name);

  /// Builds the widget for the addon.
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

  /// Builds the wrapper widget for use cases based on the current [setting].
  ///
  /// This method is called for every use case and allows the addon to wrap
  /// the use case widget with additional functionality. The [setting] parameter
  /// contains the current value selected by the user in the addon's UI.
  ///
  /// By default, this method returns the [child] widget unchanged. Override
  /// this method to implement the addon's functionality.
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
