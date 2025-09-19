import 'package:flutter/widgets.dart';

import 'addon.dart';

/// A [Mode] represents a specific configuration or state of an [Addon].
/// It holds a value of type [T] that defines the current setting of the addon.
abstract class Mode<T> {
  const Mode(this.value, this.addon);

  final T value;

  /// The associated addon for this mode. Used to build the story, and
  /// to convert to/from query parameters.
  final Addon<T> addon;

  /// Builds the [Addon] with the mode's [value].
  Widget build(BuildContext context, Widget child) {
    return addon.buildUseCase(context, child, value);
  }

  Map<String, String> toQueryGroup() {
    return addon.valueToQueryGroup(value);
  }
}
