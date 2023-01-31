import 'package:flutter/material.dart';
import 'package:widgetbook_core/src/settings/features/knobs/knob_property.dart';
import 'package:widgetbook_core/src/settings/widgets/widgets.dart';

String _defaultLabelBuilder<T>(T option) {
  return option.toString();
}

class OptionKnob<T> extends StatelessWidget {
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
  final String Function(T option) labelBuilder;
  final void Function(T value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return KnobProperty<T>(
      name: name,
      value: value,
      description: description,
      child: DropdownSetting(
        options: values,
        initialSelection: value,
        optionValueBuilder: labelBuilder,
        onSelected: (value) {
          onChanged?.call(value);
        },
      ),
    );
  }
}
