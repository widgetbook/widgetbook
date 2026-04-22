import 'package:flutter/material.dart';

/// A [FieldBuilder] is a widget that prevent useless rebuilds of the field widget when the value of the field changes.
class FieldBuilder<T> extends StatefulWidget {
  /// Creates a [FieldBuilder] with the specified configuration.
  const FieldBuilder({
    required this.group,
    required this.value,
    required this.builder,
    super.key,
  });

  /// The name of the query group param.
  final String group;

  /// The value of the field, used to determine when to rebuild the widget.
  final T? value;

  /// A builder function that creates the widget to be rendered in the settings side panel.
  final Widget Function(BuildContext) builder;

  @override
  State<FieldBuilder<T>> createState() => _FieldBuilderState<T>();
}

class _FieldBuilderState<T> extends State<FieldBuilder<T>> {
  Widget? _cachedWidget;

  @override
  void didUpdateWidget(covariant FieldBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value || widget.group != oldWidget.group) {
      _cachedWidget = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _cachedWidget ??= widget.builder(context);
  }
}
