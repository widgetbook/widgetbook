import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

class OptionsKnob<T> extends Knob<T> {
  OptionsKnob({
    required String label,
    String? description,
    required T value,
    required this.options,
  }) : super(
          label: label,
          description: description,
          value: value,
        );

  final List<Option<T>> options;

  @override
  Widget build() => OptionsKnobWidget<T>(
        key: ValueKey(this),
        label: label,
        description: description,
        value: value,
        options: options,
      );
}

class OptionsKnobWidget<T> extends StatelessWidget {
  const OptionsKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
    required this.options,
  }) : super(key: key);

  final String label;
  final String? description;
  final T value;
  final List<Option<T>> options;

  @override
  Widget build(BuildContext context) {
    return KnobWrapper(
      title: label,
      description: description,
      child: DropdownButtonFormField<Option<T>>(
        key: Key('$label-optionsKnob'),
        items: [
          for (final option in options)
            DropdownMenuItem<Option<T>>(
              value: option,
              key: Key('option-${option.label}'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(option.label),
                ],
              ),
            ),
        ],
        value: options.firstWhere((e) => identical(e.value, value)),
        onChanged: (v) {
          if (v != null) {
            context.read<KnobsNotifier>().update<T>(label, v.value);
          }
        },
      ),
    );
  }
}
