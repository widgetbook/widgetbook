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
  late String _lastGroup = widget.group;
  late T? _lastValue = widget.value;
  Widget? _cachedWidget;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cachedWidget = null;
  }

  @override
  Widget build(BuildContext context) {
    if (_cachedWidget == null ||
        widget.value != _lastValue ||
        widget.group != _lastGroup) {
      _lastValue = widget.value;
      _lastGroup = widget.group;
      _cachedWidget = widget.builder(context);
    }
    return _cachedWidget!;
  }
}
