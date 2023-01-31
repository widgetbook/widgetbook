import 'package:flutter/material.dart';
import 'package:widgetbook_core/src/settings/features/knobs/knob_property.dart';
import 'package:widgetbook_core/src/settings/widgets/widgets.dart';

String _defaultLabelBuilder<T>(T option) {
  return option.toString();
}

class OptionKnob<T> extends StatefulWidget {
  const OptionKnob({
    super.key,
    required this.name,
    this.description,
    required this.value,
    required this.values,
    String Function(T option)? labelBuilder,
    this.onChanged,
  }) : labelBuilder = labelBuilder ?? _defaultLabelBuilder;

  final String name;
  final String? description;
  final T value;
  final List<T> values;
  // TODO rename
  // TODO do we need an index parameter here?
  final String Function(T option) labelBuilder;
  final void Function(T value)? onChanged;

  @override
  State<OptionKnob<T>> createState() => _OptionKnobState<T>();
}

// TODO we can probably make this a Stateless Widget
class _OptionKnobState<T> extends State<OptionKnob<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KnobProperty<T>(
      name: widget.name,
      value: widget.value,
      description: widget.description,
      child: DropdownSetting(
        options: widget.values,
        initialSelection: widget.value,
        optionValueBuilder: widget.labelBuilder,
        onSelected: (value) {
          widget.onChanged?.call(value);
        },
      ),
    );
  }
}
