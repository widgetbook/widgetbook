import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/knobs/nullable_checkbox.dart';

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
        key: ValueKey(this),
        label: label,
        description: description,
        value: value,
      );
}

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
  Widget build() => BooleanKnobWidget(
        key: ValueKey(this),
        label: label,
        description: description,
        value: value,
        nullable: true,
      );
}

class BooleanKnobWidget extends StatefulWidget {
  const BooleanKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
    this.nullable = false,
  }) : super(key: key);

  final String label;
  final String? description;
  final bool? value;
  final bool nullable;

  @override
  State<BooleanKnobWidget> createState() => _BooleanKnobWidgetState();
}

class _BooleanKnobWidgetState extends State<BooleanKnobWidget> {
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
    final disabled = widget.value == null;
    return KnobWrapper(
        title: widget.label,
        description: widget.description,
        nullableCheckbox: widget.nullable
            ? NullableCheckbox<bool?>(
                cachedValue: value,
                value: widget.value,
                label: widget.label,
              )
            : null,
        child: SizedBox(
          child: CupertinoSwitch(
            key: Key('${widget.label}-switchTileKnob'),
            value: value,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: disabled
                ? null
                : (v) {
                    setState(() {
                      value = v;
                    });
                    context.read<KnobsNotifier>().update(widget.label, v);
                  },
          ),
        ));
  }
}
