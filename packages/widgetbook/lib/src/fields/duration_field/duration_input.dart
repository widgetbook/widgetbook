import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../common/number_text_field.dart';

@internal
class DurationInput extends StatefulWidget {
  const DurationInput({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final Duration value;
  final ValueChanged<Duration> onChanged;

  @override
  State<DurationInput> createState() => _DurationInputState();
}

class _DurationInputState extends State<DurationInput> {
  late int hours;
  late int minutes;
  late int seconds;

  @override
  void initState() {
    super.initState();
    hours = widget.value.inHours;
    minutes = widget.value.inMinutes.remainder(60);
    seconds = widget.value.inSeconds.remainder(60);
  }

  void onValuesChanged(int newHours, int newMinutes, int newSeconds) {
    setState(() {
      hours = newHours;
      minutes = newMinutes.clamp(0, 59);
      seconds = newSeconds.clamp(0, 59);
    });

    widget.onChanged.call(
      Duration(
        hours: newHours,
        minutes: newMinutes.clamp(0, 59),
        seconds: newSeconds.clamp(0, 59),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: NumberTextField(
            value: hours,
            maxLength: 6,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            labelText: 'h',
            onChanged: (value) {
              onValuesChanged(value, minutes, seconds);
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: NumberTextField(
            value: minutes,
            maxLength: 2,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^[0-5]?[0-9]$'),
                replacementString: '$minutes',
              ),
            ],
            labelText: 'm',
            onChanged: (value) {
              onValuesChanged(hours, value, seconds);
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: NumberTextField(
            value: seconds,
            maxLength: 2,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^[0-5]?[0-9]$'),
                replacementString: '$seconds',
              ),
            ],
            labelText: 's',
            onChanged: (value) {
              onValuesChanged(hours, minutes, value);
            },
          ),
        ),
      ],
    );
  }
}
