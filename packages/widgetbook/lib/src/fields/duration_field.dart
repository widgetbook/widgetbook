import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class DurationField extends Field<Duration> {
  DurationField({
    required super.name,
    super.initialValue = defaultDuration,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
          type: FieldType.duration,
          codec: FieldCodec(
            toParam: (value) => value.inMilliseconds.toString(),
            toValue: (param) {
              return param == null
                  ? null
                  : Duration(
                      milliseconds: int.tryParse(param) ?? 0,
                    );
            },
          ),
        );

  static const defaultDuration = Duration.zero;

  @override
  Widget toWidget(
    BuildContext context,
    String group,
    Duration? value,
  ) {
    return _DurationFieldWidget(
      group: group,
      initialValue: value ?? defaultDuration,
      updateField: updateField,
    );
  }
}

class _DurationFieldWidget extends StatefulWidget {
  const _DurationFieldWidget({
    required this.group,
    required this.initialValue,
    required this.updateField,
  });
  final String group;
  final Duration initialValue;
  final void Function(BuildContext context, String group, Duration value)
      updateField;

  @override
  __DurationFieldWidgetState createState() => __DurationFieldWidgetState();
}

class __DurationFieldWidgetState extends State<_DurationFieldWidget> {
  late final TextEditingController daysController;
  late final TextEditingController hoursController;
  late final TextEditingController minutesController;
  late final TextEditingController secondsController;

  late final FocusNode daysFocusNode;
  late final FocusNode hoursFocusNode;
  late final FocusNode minutesFocusNode;
  late final FocusNode secondsFocusNode;

  @override
  void initState() {
    super.initState();

    daysController = TextEditingController(
      text: (widget.initialValue.inDays).toString().padLeft(2, '0'),
    );
    hoursController = TextEditingController(
      text: (widget.initialValue.inHours.remainder(24))
          .toString()
          .padLeft(2, '0'),
    );
    minutesController = TextEditingController(
      text: (widget.initialValue.inMinutes.remainder(60))
          .toString()
          .padLeft(2, '0'),
    );
    secondsController = TextEditingController(
      text: (widget.initialValue.inSeconds.remainder(60))
          .toString()
          .padLeft(2, '0'),
    );
  }

  @override
  void dispose() {
    daysController.dispose();
    hoursController.dispose();
    minutesController.dispose();
    secondsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: daysController,
            maxLength: 2,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'd', counterText: ''),
            onChanged: (_) {
              _updateDuration();
            },
          ),
        ),
        const Text(':'),
        Expanded(
          child: TextFormField(
            controller: hoursController,
            maxLength: 2,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'h', counterText: ''),
            onChanged: (_) {
              _updateDuration();
            },
          ),
        ),
        const Text(':'),
        Expanded(
          child: TextFormField(
            controller: minutesController,
            maxLength: 2,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'm', counterText: ''),
            onChanged: (_) {
              _updateDuration();
            },
          ),
        ),
        const Text(':'),
        Expanded(
          child: TextFormField(
            controller: secondsController,
            maxLength: 2,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 's', counterText: ''),
            onChanged: (_) {
              _updateDuration();
            },
          ),
        ),
      ],
    );
  }

  void _updateDuration() {
    final days = int.tryParse(daysController.text) ?? 0;
    final hours = int.tryParse(hoursController.text) ?? 0;
    final minutes = int.tryParse(minutesController.text) ?? 0;
    final seconds = int.tryParse(secondsController.text) ?? 0;

    final newDuration = Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );

    widget.updateField(context, widget.group, newDuration);
  }
}
