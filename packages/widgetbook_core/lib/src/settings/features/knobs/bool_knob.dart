import 'package:flutter/material.dart';
import 'package:widgetbook_core/src/settings/features/knobs/knob_property.dart';

class BoolKnob extends StatefulWidget {
  const BoolKnob({
    super.key,
    required this.name,
    this.description,
    required this.value,
    this.onChanged,
  });

  final String name;
  final String? description;
  final bool value;
  final void Function(bool value)? onChanged;

  @override
  State<BoolKnob> createState() => _BoolKnobState();
}

class _BoolKnobState extends State<BoolKnob> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return KnobProperty<bool>(
      name: widget.name,
      value: widget.value,
      description: widget.description,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Switch(
            value: value,
            onChanged: (value) {
              setState(() {
                this.value = value;
              });
              widget.onChanged?.call(value);
            },
          ),
        ),
      ),
    );
  }
}

class NullableBoolKnob extends StatefulWidget {
  const NullableBoolKnob({
    super.key,
    required this.name,
    this.description,
    required this.value,
    this.onChanged,
  });

  final String name;
  final String? description;
  final bool? value;
  final void Function(bool? value)? onChanged;

  @override
  State<NullableBoolKnob> createState() => _NullableBoolKnobState();
}

class _NullableBoolKnobState extends State<NullableBoolKnob> {
  late bool value;
  late bool isNull;

  @override
  void initState() {
    super.initState();
    value = widget.value ?? false;
    isNull = widget.value == null;
  }

  void _callOnChanged() {
    widget.onChanged?.call(isNull ? null : value);
  }

  @override
  Widget build(BuildContext context) {
    return KnobProperty<bool?>(
      name: widget.name,
      value: widget.value,
      description: widget.description,
      changedNullable: (isNull) {
        setState(() {
          this.isNull = isNull;
        });
        _callOnChanged();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Switch(
          value: value,
          onChanged: isNull
              ? null
              : (value) {
                  setState(() {
                    this.value = value;
                  });
                  _callOnChanged();
                },
        ),
      ),
    );
  }
}
