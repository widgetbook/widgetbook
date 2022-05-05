import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/knobs/nullable_checkbox.dart';

class NumberKnob extends Knob<num> {
  NumberKnob({
    required String label,
    String? description,
    required num value,
  }) : super(
          label: label,
          description: description,
          value: value,
        );

  @override
  Widget build() => NumberKnobWidget(
        key: ValueKey(this),
        label: label,
        description: description,
        value: value,
      );
}

class NullableNumberKnob extends Knob<num?> {
  NullableNumberKnob({
    required String label,
    String? description,
    required num? value,
  }) : super(
          label: label,
          description: description,
          value: value,
        );

  @override
  Widget build() => NumberKnobWidget(
        key: ValueKey(this),
        label: label,
        description: description,
        value: value,
        nullable: true,
      );
}

class NumberKnobWidget extends StatefulWidget {
  const NumberKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
    this.nullable = false,
  }) : super(key: key);

  final String label;
  final String? description;
  final num? value;
  final bool nullable;

  @override
  State<NumberKnobWidget> createState() => _NumberKnobWidgetState();
}

class _NumberKnobWidgetState extends State<NumberKnobWidget> {
  final controller = TextEditingController();
  num _value = 0;

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      _value = widget.value!;
      controller.text = widget.value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final disabled = widget.value == null;
    return KnobWrapper(
      title: widget.label,
      nullableCheckbox: widget.nullable
          ? NullableCheckbox<num?>(
              cachedValue: _value,
              value: widget.value,
              label: widget.label,
            )
          : null,
      description: widget.description,
      child: TextField(
        key: Key('${widget.label}-numberKnob'),
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
        ],
        decoration: const InputDecoration(
          isDense: true,
        ),
        onChanged: disabled
            ? null
            : (v) {
                try {
                  final value = num.parse(v);
                  setState(() {
                    _value = value;
                  });
                  context.read<KnobsNotifier>().update(widget.label, value);
                } catch (e) {
                  context.read<KnobsNotifier>().update(widget.label, 0);
                }
              },
      ),
    );
  }
}
