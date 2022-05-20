import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/knobs/nullable_checkbox.dart';

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
        key: ValueKey(this),
      );
}

class NullableTextKnob extends Knob<String?> {
  NullableTextKnob({
    required String label,
    String? description,
    required String? value,
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
        nullable: true,
        key: ValueKey(this),
      );
}

class TextKnobWidget extends StatefulWidget {
  const TextKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
    this.nullable = false,
  }) : super(key: key);

  final String label;
  final String? description;
  final String? value;
  final bool nullable;

  @override
  State<TextKnobWidget> createState() => _TextKnobWidgetState();
}

class _TextKnobWidgetState extends State<TextKnobWidget> {
  String value = '';
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      controller.text = widget.value!;
      value = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return KnobWrapper(
      description: widget.description,
      title: widget.label,
      nullableCheckbox: widget.nullable
          ? NullableCheckbox<String?>(
              cachedValue: value,
              value: widget.value,
              label: widget.label,
            )
          : null,
      child: TextField(
        key: Key('${widget.label}-textKnob'),
        controller: controller,
        onChanged: (v) {
          setState(() {
            value = v;
          });
          context.read<KnobsNotifier>().update(widget.label, v);
        },
      ),
    );
  }
}
