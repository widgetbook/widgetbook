import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:widgetbook/src/knobs/knobs.dart';

class BoolKnob extends Knob<bool> {
  BoolKnob({
    required String label,
    String? description,
    required bool value,
  }) : super(
          label: label,
          description: description,
          value: value,
        );

  @override
  Widget build() => BooleanKnobWidget(
        label: label,
        description: description,
        value: value,
      );
}

class BooleanKnobWidget extends StatelessWidget {
  const BooleanKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
  }) : super(key: key);

  final String label;
  final String? description;
  final bool value;

  @override
  Widget build(BuildContext context) => KnobWrapper(
        description: description,
        child: SwitchListTile(
          key: Key('$label-switchTileKnob'),
          title: Text(label, overflow: TextOverflow.ellipsis),
          subtitle: description == null ? null : Text(description!),
          value: value,
          onChanged: (v) => context.read<KnobsNotifier>().update(label, v),
        ),
      );
}
