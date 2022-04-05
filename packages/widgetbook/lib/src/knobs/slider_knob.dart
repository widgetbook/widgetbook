import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:widgetbook/src/knobs/knobs.dart';

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
        label: label,
        description: description,
        value: value,
        min: min,
        max: max,
        divisions: divisions,
      );
}

class SliderKnobWidget extends StatelessWidget {
  const SliderKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
    required this.max,
    required this.min,
    required this.divisions,
  }) : super(key: key);

  final String label;
  final String? description;
  final double value;

  final double max;
  final double min;
  final int? divisions;

  @override
  Widget build(BuildContext context) {
    return KnobWrapper(
      description: description,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Text(
              '$label:',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Slider(
            key: Key('$label-sliderKnob'),
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              // Could use on change end? Maybe that will help?
              onChanged: (v) {
                context.read<KnobsNotifier>().update(label, v);
              },
              label: value.toStringAsFixed(2),
            ),
          ),
        ],
      ),
    );
  }
}
