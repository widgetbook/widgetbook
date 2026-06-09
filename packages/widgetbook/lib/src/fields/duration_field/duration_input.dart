import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../common/number_text_field.dart';

@internal
class DurationInput extends StatefulWidget {
  const DurationInput({
    super.key,
    required this.value,
    required this.enableDays,
    required this.enableHours,
    required this.enableMinutes,
    required this.enableSeconds,
    required this.enableMilliseconds,
    required this.enableMicroseconds,
    required this.onChanged,
  });

  final Duration value;
  final bool enableDays;
  final bool enableHours;
  final bool enableMinutes;
  final bool enableSeconds;
  final bool enableMilliseconds;
  final bool enableMicroseconds;
  final ValueChanged<Duration> onChanged;

  @override
  State<DurationInput> createState() => _DurationInputState();
}

class _DurationInputState extends State<DurationInput> {
  late int days;
  late int hours;
  late int minutes;
  late int seconds;
  late int milliseconds;
  late int microseconds;

  @override
  void initState() {
    super.initState();
    days = widget.value.inDays;
    hours = widget.value.inHours.remainder(24);
    minutes = widget.value.inMinutes.remainder(60);
    seconds = widget.value.inSeconds.remainder(60);
    milliseconds = widget.value.inMilliseconds.remainder(1000);
    microseconds = widget.value.inMicroseconds.remainder(1000);
  }

  void onValuesChanged(
    int newDays,
    int newHours,
    int newMinutes,
    int newSeconds,
    int newMilliseconds,
    int newMicroseconds,
  ) {
    setState(() {
      days = newDays;
      hours = newHours;
      minutes = newMinutes.clamp(0, 59);
      seconds = newSeconds.clamp(0, 59);
      milliseconds = newMilliseconds.clamp(0, 999);
      microseconds = newMicroseconds.clamp(0, 999);
    });

    widget.onChanged.call(
      Duration(
        days: newDays,
        hours: newHours,
        minutes: newMinutes.clamp(0, 59),
        seconds: newSeconds.clamp(0, 59),
        milliseconds: newMilliseconds.clamp(0, 999),
        microseconds: newMicroseconds.clamp(0, 999),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        if (widget.enableDays)
          Expanded(
            child: NumberTextField(
              value: days,
              maxLength: 6,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              labelText: 'd',
              onChanged: (value) {
                onValuesChanged(
                  value,
                  hours,
                  minutes,
                  seconds,
                  milliseconds,
                  microseconds,
                );
              },
            ),
          ),
        if (widget.enableHours)
          Expanded(
            child: NumberTextField(
              value: hours,
              maxLength: 6,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              labelText: 'h',
              onChanged: (value) {
                onValuesChanged(
                  days,
                  value,
                  minutes,
                  seconds,
                  milliseconds,
                  microseconds,
                );
              },
            ),
          ),
        if (widget.enableMinutes)
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
                onValuesChanged(
                  days,
                  hours,
                  value,
                  seconds,
                  milliseconds,
                  microseconds,
                );
              },
            ),
          ),
        if (widget.enableSeconds)
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
                onValuesChanged(
                  days,
                  hours,
                  minutes,
                  value,
                  milliseconds,
                  microseconds,
                );
              },
            ),
          ),
        if (widget.enableMilliseconds)
          Expanded(
            child: NumberTextField(
              value: milliseconds,
              maxLength: 3,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(
                  RegExp(r'^[0-9]{0,3}$'),
                  replacementString: '$milliseconds',
                ),
              ],
              labelText: 'ms',
              onChanged: (value) {
                onValuesChanged(
                  days,
                  hours,
                  minutes,
                  seconds,
                  value,
                  microseconds,
                );
              },
            ),
          ),
        if (widget.enableMicroseconds)
          Expanded(
            child: NumberTextField(
              value: microseconds,
              maxLength: 3,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(
                  RegExp(r'^[0-9]{0,3}$'),
                  replacementString: '$microseconds',
                ),
              ],
              labelText: 'µs',
              onChanged: (value) {
                onValuesChanged(
                  days,
                  hours,
                  minutes,
                  seconds,
                  milliseconds,
                  value,
                );
              },
            ),
          ),
      ],
    );
  }
}
