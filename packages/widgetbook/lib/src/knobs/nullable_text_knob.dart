import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/knobs/nullable_checkbox.dart';

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
  Widget build() => NullableTexteanKnobWidget(
        label: label,
        description: description,
        value: value,
      );
}

class NullableTexteanKnobWidget extends StatefulWidget {
  const NullableTexteanKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
  }) : super(key: key);

  final String label;
  final String? description;
  final String? value;

  @override
  State<NullableTexteanKnobWidget> createState() =>
      _NullableTexteanKnobWidgetState();
}

class _NullableTexteanKnobWidgetState extends State<NullableTexteanKnobWidget> {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Text(
              '${widget.label}:',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              key: Key('${widget.label}-nullableTextKnob'),
              controller: controller,
              decoration: const InputDecoration(
                isDense: true,
              ),
              onChanged: (v) {
                setState(() {
                  value = v;
                });
                context.read<KnobsNotifier>().update(widget.label, v);
              },
            ),
          ),
          NullableCheckbox(
            cachedValue: value,
            value: widget.value,
            label: widget.label,
          )
        ],
      ),
    );
  }
}
