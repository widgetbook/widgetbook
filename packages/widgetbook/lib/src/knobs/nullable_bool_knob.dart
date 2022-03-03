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

class NullableBooleanKnobWidget extends StatefulWidget {
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
  State<NullableBooleanKnobWidget> createState() =>
      _NullableBooleanKnobWidgetState();
}

class _NullableBooleanKnobWidgetState extends State<NullableBooleanKnobWidget> {
  bool value = false;

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      value = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _disabled = widget.value == null;
    return ListTile(
      title: Text(widget.label, overflow: TextOverflow.ellipsis),
      dense: true,
      subtitle: widget.description == null ? null : Text(widget.description!),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Switch(
            key: Key('${widget.label}-switchTileKnob'),
            value: value,
            onChanged: _disabled
                ? null
                : (v) {
                    setState(() {
                      value = v;
                    });
                    context.read<KnobsNotifier>().update(widget.label, v);
                  },
          ),
          Checkbox(
            key: Key('${widget.label}-switchTileKnob-check'),
            value: _disabled,
            onChanged: (v) {
              bool? newValue;
              switch (v) {
                case null:
                case true:
                  newValue = null;
                  break;
                case false:
                  newValue = value;
              }
              context.read<KnobsNotifier>().update(widget.label, newValue);
            },
          )
        ],
      ),
    );
  }
}
