import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/knobs/nullable_checkbox.dart';

class TextKnob extends Knob<String> {
  TextKnob({
    required super.label,
    super.description,
    required super.value,
    required this.multiline,
  });
  final bool multiline;
  @override
  Widget build() => TextKnobWidget(
        label: label,
        multiline: multiline,
        description: description,
        value: value,
        key: ValueKey(this),
      );
}

class NullableTextKnob extends Knob<String?> {
  NullableTextKnob({
    required super.label,
    super.description,
    required super.value,
    required this.multiline,
  });
  final bool multiline;
  @override
  Widget build() => TextKnobWidget(
        label: label,
        description: description,
        value: value,
        nullable: true,
        multiline: multiline,
        key: ValueKey(this),
      );
}

class TextKnobWidget extends StatefulWidget {
  const TextKnobWidget({
    super.key,
    required this.label,
    required this.description,
    required this.value,
    required this.multiline,
    this.nullable = false,
  });

  final String label;
  final String? description;
  final String? value;
  final bool nullable;
  final bool multiline;

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
        maxLines: widget.multiline ? null : 1,
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
