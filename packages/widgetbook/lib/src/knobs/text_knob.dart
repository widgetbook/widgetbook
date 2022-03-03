import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:widgetbook/src/knobs/knobs.dart';

class TextKnob extends Knob<String> {
  TextKnob({
    required String label,
    String? description,
    required String value,
  }) : super(
          label: label,
          description: description,
          value: value,
        );

  @override
  Widget build() => TextKnobWidget(
        label: label,
        description: description,
        value: value,
      );
}

class TextKnobWidget extends StatefulWidget {
  const TextKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
  }) : super(key: key);

  final String label;
  final String? description;
  final String value;

  @override
  State<TextKnobWidget> createState() => _TextKnobWidgetState();
}

class _TextKnobWidgetState extends State<TextKnobWidget> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key('${widget.label}-switchTileKnob'),
      title: Text(widget.label, overflow: TextOverflow.ellipsis),
      subtitle: widget.description == null ? null : Text(widget.description!),
      trailing: Expanded(
          child: TextField(
        key: Key('${widget.label}-textKnob'),
        controller: controller,
        onChanged: (v) {
          context.read<KnobsNotifier>().update(widget.label, v);
        },
      )),
    );
  }
}
