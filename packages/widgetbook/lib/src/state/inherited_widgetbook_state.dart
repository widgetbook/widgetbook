import 'package:flutter/widgets.dart';

import 'widgetbook_scope.dart';
import 'widgetbook_state.dart';

/// An [InheritedWidget] that provides access to [WidgetbookState] for its descendants.
///
/// This is used to ensure that the WidgetbookState is accessible within nested navigators,
/// particularly when using DeviceFrameAddon which creates a new Navigator.
class InheritedWidgetbookState extends InheritedWidget {
  /// Creates an [InheritedWidgetbookState].
  const InheritedWidgetbookState({
    super.key,
    required this.state,
    required super.child,
  });

  /// The [WidgetbookState] to be provided to descendants.
  final WidgetbookState state;

  @override
  bool updateShouldNotify(InheritedWidgetbookState oldWidget) {
    return state != oldWidget.state;
  }

  /// Finds the [WidgetbookState] in the widget tree.
  ///
  /// This method first tries to find an [InheritedWidgetbookState] in the widget tree.
  /// If not found, it falls back to [WidgetbookState.maybeOf].
  ///
  /// This approach ensures that knobs work correctly even when nested in a Navigator
  /// (like with DeviceFrameAddon).
  static WidgetbookState? maybeOf(BuildContext context) {
    // First try to find an InheritedWidgetbookState
    final inheritedWidget = context.dependOnInheritedWidgetOfExactType<InheritedWidgetbookState>();
    if (inheritedWidget != null) {
      return inheritedWidget.state;
    }
    
    // Fall back to the regular WidgetbookScope
    return context.dependOnInheritedWidgetOfExactType<WidgetbookScope>()?.notifier;
  }

  /// Finds the [WidgetbookState] in the widget tree.
  ///
  /// This method first tries to find an [InheritedWidgetbookState] in the widget tree.
  /// If not found, it falls back to [WidgetbookState.of].
  ///
  /// This approach ensures that knobs work correctly even when nested in a Navigator
  /// (like with DeviceFrameAddon).
  static WidgetbookState of(BuildContext context) {
    final state = maybeOf(context);
    assert(state != null, 'No WidgetbookState found in the context.');
    return state!;
  }
}
