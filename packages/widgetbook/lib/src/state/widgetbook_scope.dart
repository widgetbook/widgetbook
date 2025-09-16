import 'package:flutter/widgets.dart';

import 'widgetbook_state.dart';

/// The [WidgetbookScope] is an [InheritedNotifier] that provides access to the
/// [WidgetbookState] to its descendants.
///
/// You can can access the state as follows:
///
/// ```dart
/// final state = WidgetbookState.of(context);
/// ```
class WidgetbookScope extends InheritedNotifier<WidgetbookState> {
  /// Creates a [WidgetbookScope] with the given initial [state] and [child].
  WidgetbookScope({
    super.key,
    required WidgetbookState state,
    required super.child,
  }) : super(
         notifier: state,
       );
}
