import 'package:flutter/material.dart';
import 'package:widgetbook_core/src/settings/features/knobs/knob_padding.dart';
import 'package:widgetbook_core/src/settings/features/knobs/knob_property.dart';

String? _errorText(String value) {
  return num.tryParse(value) == null ? 'Not a number' : null;
}

class NumberKnob extends StatefulWidget {
  const NumberKnob({
    super.key,
    required this.name,
    this.description,
    required this.value,
    this.onChanged,
  });

  final String name;
  final String? description;
  final num value;
  final void Function(num value)? onChanged;

  @override
  State<NumberKnob> createState() => _NumberKnobState();
}

class _NumberKnobState extends State<NumberKnob> {
  late num value;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    value = widget.value;
    controller = TextEditingController(text: widget.value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return KnobProperty<num>(
      name: widget.name,
      value: widget.value,
      description: widget.description,
      child: SizedBox(
        child: KnobPadding(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              errorText: _errorText(controller.text),
            ),
            onChanged: (value) {
              final intValue = num.tryParse(value);
              if (intValue != null) {
                this.value = intValue;
                widget.onChanged?.call(this.value);
              }
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}

class NullableNumberKnob extends StatefulWidget {
  const NullableNumberKnob({
    super.key,
    required this.name,
    this.description,
    required this.value,
    this.onChanged,
  });

  final String name;
  final String? description;
  final num? value;
  final void Function(num? value)? onChanged;

  @override
  State<NullableNumberKnob> createState() => _NullableNumberKnobState();
}

class _NullableNumberKnobState extends State<NullableNumberKnob> {
  late TextEditingController controller;
  late num value;
  late bool isNull;

  @override
  void initState() {
    super.initState();
    value = widget.value ?? 0;
    isNull = widget.value == null;
    controller = TextEditingController(text: value.toString());
  }

  void _callOnChanged() {
    widget.onChanged?.call(isNull ? null : value);
  }

  @override
  Widget build(BuildContext context) {
    return KnobProperty<num?>(
      name: widget.name,
      value: widget.value,
      description: widget.description,
      changedNullable: (isNull) {
        setState(() {
          this.isNull = isNull;
        });
        _callOnChanged();
      },
      child: KnobPadding(
        child: TextField(
          enabled: !isNull,
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            errorText: _errorText(controller.text),
          ),
          onChanged: (value) {
            final intValue = num.tryParse(value);
            if (intValue != null) {
              this.value = intValue;
              widget.onChanged?.call(this.value);
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}
