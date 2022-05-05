import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/knobs/nullable_checkbox.dart';

class SliderKnob extends Knob<double> {
  SliderKnob({
    required String label,
    String? description,
    required double value,
    this.max = 1,
    this.min = 0,
    this.divisions,
  }) : super(
          label: label,
          description: description,
          value: value,
        );

  final double max;
  final double min;
  final int? divisions;

  @override
  Widget build() => SliderKnobWidget(
        key: ValueKey(this),
        label: label,
        description: description,
        value: value,
        min: min,
        max: max,
        divisions: divisions,
      );
}

class NullableSliderKnob extends Knob<double?> {
  NullableSliderKnob({
    required String label,
    String? description,
    required double value,
    this.max = 1,
    this.min = 0,
    this.divisions,
  }) : super(
          label: label,
          description: description,
          value: value,
        );

  final double max;
  final double min;
  final int? divisions;

  @override
  Widget build() => SliderKnobWidget(
        key: ValueKey(this),
        label: label,
        description: description,
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        nullable: true,
      );
}

class SliderKnobWidget extends StatefulWidget {
  const SliderKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
    required this.max,
    required this.min,
    required this.divisions,
    this.nullable = false,
  }) : super(key: key);

  final String label;
  final String? description;
  final double? value;

  final double max;
  final double min;
  final int? divisions;
  final bool nullable;

  @override
  State<SliderKnobWidget> createState() => _SliderKnobWidgetState();
}

class _SliderKnobWidgetState extends State<SliderKnobWidget> {
  double _value = 0;
  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      _value = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final disabled = widget.value == null;
    return KnobWrapper(
      title: '${widget.label} (${_value.toStringAsFixed(2)})',
      description: widget.description,
      nullableCheckbox: widget.nullable
          ? NullableCheckbox<double?>(
              cachedValue: _value,
              value: widget.value,
              label: widget.label,
            )
          : null,
      child: Slider(
        key: Key('${widget.label}-sliderKnob'),
        value: _value,
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,
        onChanged: disabled
            ? null
            : (v) {
                setState(() {
                  _value = v;
                });
                context.read<KnobsNotifier>().update(widget.label, v);
              },
        label: _value.toStringAsFixed(2),
      ),
    );
  }
}
