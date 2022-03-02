import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:widgetbook/src/knobs/knobs.dart';

class NullableBoolKnob extends Knob<bool?> {
  NullableBoolKnob({
    required String label,
    String? description,
    required bool? value,
  }) : super(
          label: label,
          description: description,
          value: value,
        );

  @override
  Widget build() => NullableBooleanKnobWidget(
        label: label,
        description: description,
        value: value,
      );
}

class NullableBooleanKnobWidget extends StatelessWidget {
  const NullableBooleanKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
  }) : super(key: key);

  final String label;
  final String? description;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    final _val = value ?? false;
    final _disabled = value == null;
    return Wrap(
      children: [
        SwitchListTile(
          key: Key('$label-switchTileKnob'),
          title: Text(label, overflow: TextOverflow.ellipsis),
          subtitle: description == null ? null : Text(description!),
          value: _val,
          onChanged: _disabled
              ? null
              : (v) => context.read<KnobsNotifier>().update(label, v),
        ),
        Checkbox(
        key: Key('$label-switchTileKnob-check'),
          value: _disabled,
          onChanged: (v) {
            bool? newValue;
            switch (v) {
              case null:
              case true:
                newValue = null;
                break;
              default:
                newValue = false;
            }
            context.read<KnobsNotifier>().update(label, newValue);
          },
        )
      ],
    );
  }
}
