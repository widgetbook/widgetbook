import 'package:flutter/material.dart';
import 'package:widgetbook_core/src/settings/features/knobs/knob_property.dart';

// TODO we might be able to make this a stateless widget
class TextKnob extends StatefulWidget {
  const TextKnob({
    super.key,
    required this.name,
    this.description,
    required this.value,
    this.maxLines = 1,
    this.onChanged,
  });

  final String name;
  final String? description;
  final String value;
  final int? maxLines;
  final void Function(String value)? onChanged;

  @override
  State<TextKnob> createState() => _TextKnobState();
}

class _TextKnobState extends State<TextKnob> {
  late String value;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    value = widget.value;
    controller = TextEditingController(text: value);
  }

  @override
  Widget build(BuildContext context) {
    return KnobProperty<String>(
      name: widget.name,
      value: widget.value,
      description: widget.description,
      child: SizedBox(
        // TODO do we need to have an own widget for this?
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: TextField(
            controller: controller,
            maxLines: widget.maxLines,
            onChanged: (v) {
              setState(() {
                value = v;
              });
              widget.onChanged?.call(v);
            },
          ),
        ),
      ),
    );
  }
}

class NullableTextKnob extends StatefulWidget {
  const NullableTextKnob({
    super.key,
    required this.name,
    this.description,
    required this.value,
    this.maxLines = 1,
    this.onChanged,
  });

  final String name;
  final String? description;
  final String? value;
  final int? maxLines;
  final void Function(String? value)? onChanged;

  @override
  State<NullableTextKnob> createState() => _NullableTextKnobState();
}

class _NullableTextKnobState extends State<NullableTextKnob> {
  late String value;
  late bool isNull;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    value = widget.value ?? '';
    isNull = widget.value == null;
    controller = TextEditingController(text: value);
  }

  void _callOnChanged() {
    widget.onChanged?.call(isNull ? null : value);
  }

  @override
  Widget build(BuildContext context) {
    return KnobProperty<String?>(
      name: widget.name,
      value: widget.value,
      description: widget.description,
      changedNullable: (isNull) {
        setState(() {
          this.isNull = isNull;
        });
        _callOnChanged();
      },
      // TODO do we need to have an own widget for this?
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: TextField(
          controller: controller,
          maxLines: widget.maxLines,
          onChanged: (v) {
            setState(() {
              value = v;
            });
            widget.onChanged?.call(v);
          },
        ),
      ),
    );
  }
}
