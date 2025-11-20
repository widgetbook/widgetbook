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
    required super.initialValue,
  });

  @override
  String get groupName => slugify(name);

  Widget build(BuildContext context, Widget child) {
    // State can be null in Scenarios, in that case group will be null,
    // causing valueFromQueryGroup to return initialValue.
    final state = WidgetbookState.maybeOf(context);
    final group = state?.queryGroups[groupName];
    final newSetting = valueFromQueryGroup(group);

    return apply(
      context,
      child,
      newSetting,
    );
  }

  /// Applies this to [child] which is usually the story using the [setting]
  /// that is obtained from [valueFromQueryGroup].
  Widget apply(
    BuildContext context,
    Widget child,
    T setting,
  );
}
