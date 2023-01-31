import 'package:flutter/material.dart';
import 'package:widgetbook_core/src/settings/features/knobs/knob_property.dart';

class SliderKnob extends StatefulWidget {
  const SliderKnob({
    super.key,
    required this.name,
    this.description,
    required this.value,
    this.max = 1,
    this.min = 0,
    this.divisions,
    this.onChanged,
  });

  final String name;
  final String? description;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final void Function(double value)? onChanged;

  @override
  State<SliderKnob> createState() => _SliderKnobState();
}

class _SliderKnobState extends State<SliderKnob> {
  late double value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return KnobProperty(
      name: widget.name,
      description: widget.description,
      value: value,
      trailing: Text(value.toStringAsFixed(2)),
      child: Slider(
        value: value,
        min: widget.min,
        max: widget.max,
        label: value.toStringAsFixed(2),
        divisions: widget.divisions,
        onChanged: (value) {
          setState(() {
            this.value = value;
            widget.onChanged?.call(value);
          });
        },
      ),
    );
  }
}

class NullableSliderKnob extends StatefulWidget {
  const NullableSliderKnob({
    super.key,
    required this.name,
    this.description,
    required this.value,
    this.max = 1,
    this.min = 0,
    this.divisions,
    this.onChanged,
  });

  final String name;
  final String? description;
  final double? value;
  final double min;
  final double max;
  final int? divisions;
  final void Function(double? value)? onChanged;

  @override
  State<NullableSliderKnob> createState() => _NullableSliderKnobState();
}

class _NullableSliderKnobState extends State<NullableSliderKnob> {
  late double value;
  late bool isNull;

  @override
  void initState() {
    super.initState();
    value = widget.value ?? widget.min;
    isNull = widget.value == null;
  }

  void _callOnChanged() {
    widget.onChanged?.call(isNull ? null : value);
  }

  @override
  Widget build(BuildContext context) {
    return KnobProperty<double?>(
      name: widget.name,
      description: widget.description,
      value: value,
      trailing: isNull ? null : Text(value.toStringAsFixed(2)),
      changedNullable: (isNull) {
        setState(() {
          this.isNull = isNull;
        });
        _callOnChanged();
      },
      child: Slider(
        value: value,
        min: widget.min,
        max: widget.max,
        label: value.toStringAsFixed(2),
        divisions: widget.divisions,
        onChanged: isNull
            ? null
            : (value) {
                setState(() {
                  this.value = value;
                  _callOnChanged();
                });
              },
      ),
    );
  }
}
