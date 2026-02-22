part of '../field.dart';

/// A [Field] that represents a [Duration] value.
final class DurationField extends Field<Duration> {
  /// Creates a new instance of [DurationField].
  DurationField({
    required super.name,
    super.initialValue = defaultDuration,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         toParam: (value) => value.inMilliseconds.toString(),
         toValue: (param) {
           final ms = int.tryParse(param);
           if (ms == null) return null;
           return Duration(milliseconds: ms);
         },
       );

  /// The default duration value used when no initial value is provided.
  static const defaultDuration = Duration.zero;

  @override
  Widget toWidget(BuildContext context, String groupName, Duration value) {
    return DurationInput(
      value: value,
      onChanged: (duration) {
        updateField(context, groupName, duration);
      },
    );
  }
}

class _DurationInput extends StatefulWidget {
  const _DurationInput({
    required this.value,
    required this.onChanged,
  });

  final Duration value;
  final ValueChanged<Duration> onChanged;

  @override
  State<_DurationInput> createState() => _DurationInputState();
}

class _DurationInputState extends State<_DurationInput> {
  static final _hoursFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'^([01]?[0-9]?|2[0-3]?)$'),
  );
  static final _minutesSecondsFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'^([0-5]?[0-9]?)$'),
  );
  static final _millisecondsFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'^([0-9]{0,3})$'),
  );

  late int hours;
  late int minutes;
  late int seconds;
  late int milliseconds;

  @override
  void initState() {
    super.initState();
    _setFromDuration(widget.value);
  }

  @override
  void didUpdateWidget(covariant _DurationInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _setFromDuration(widget.value);
    }
  }

  void _setFromDuration(Duration value) {
    hours = value.inHours.remainder(24);
    minutes = value.inMinutes.remainder(60);
    seconds = value.inSeconds.remainder(60);
    milliseconds = value.inMilliseconds.remainder(1000);
  }

  void _emitDuration() {
    widget.onChanged(
      Duration(
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Expanded(
          flex: 2,
          child: _DurationUnitField(
            value: hours,
            maxLength: 2,
            labelText: 'h',
            inputFormatters: [_hoursFormatter],
            onChanged: (value) {
              setState(() {
                hours = value.clamp(0, 23);
              });
              _emitDuration();
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: _DurationUnitField(
            value: minutes,
            maxLength: 2,
            labelText: 'm',
            inputFormatters: [_minutesSecondsFormatter],
            onChanged: (value) {
              setState(() {
                minutes = value.clamp(0, 59);
              });
              _emitDuration();
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: _DurationUnitField(
            value: seconds,
            maxLength: 2,
            labelText: 's',
            inputFormatters: [_minutesSecondsFormatter],
            onChanged: (value) {
              setState(() {
                seconds = value.clamp(0, 59);
              });
              _emitDuration();
            },
          ),
        ),
        Expanded(
          flex: 3,
          child: _DurationUnitField(
            value: milliseconds,
            maxLength: 3,
            labelText: 'ms',
            inputFormatters: [_millisecondsFormatter],
            onChanged: (value) {
              setState(() {
                milliseconds = value.clamp(0, 999);
              });
              _emitDuration();
            },
          ),
        ),
      ],
    );
  }
}

class _DurationUnitField extends StatelessWidget {
  const _DurationUnitField({
    required this.value,
    required this.maxLength,
    required this.labelText,
    required this.inputFormatters,
    required this.onChanged,
  });

  final int value;
  final int maxLength;
  final String labelText;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return ControlledTextField(
      initialValue: '$value',
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength),
        ...inputFormatters,
      ],
      decoration: InputDecoration(
        hintText: '0' * maxLength,
        labelText: labelText,
        // Make the TextField more dense by reducing the default content padding
        //
        // Allows to fit the hours, minutes, seconds and milliseconds fields in
        // a single line without overflow
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 12,
        ),
      ),
      onChanged: (text) {
        final parsedValue = int.tryParse(text) ?? 0;
        onChanged(parsedValue);
      },
    );
  }
}
