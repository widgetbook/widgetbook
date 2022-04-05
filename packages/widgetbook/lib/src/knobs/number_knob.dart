import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:widgetbook/src/knobs/knobs.dart';

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
        label: label,
        description: description,
        value: value,
      );
}

class NumberKnobWidget extends StatefulWidget {
  const NumberKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
  }) : super(key: key);

  final String label;
  final String? description;
  final num value;

  @override
  State<NumberKnobWidget> createState() => _NumberKnobWidgetState();
}

class _NumberKnobWidgetState extends State<NumberKnobWidget> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.value.toString();
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
              key: Key('${widget.label}-numberKnob'),
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
              ],
              decoration: const InputDecoration(
                isDense: true,
              ),
              onChanged: (v) {
                try {
                  context
                      .read<KnobsNotifier>()
                      .update(widget.label, num.parse(v));
                } catch (e) {
                  context
                      .read<KnobsNotifier>()
                      .update(widget.label, 0);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
