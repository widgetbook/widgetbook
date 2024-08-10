import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class DurationField extends Field<Duration> {
  DurationField({
    required super.name,
    super.initialValue = defaultDuration,
    @deprecated super.onChanged,
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
    final formattedDuration =
        _formatDuration(value ?? initialValue ?? defaultDuration);
    TextEditingController _controller = TextEditingController(
      text: formattedDuration,
    );

    return StatefulBuilder(
      builder: (context, setstate) {
        return TextFormField(
          controller: _controller,
          keyboardType: TextInputType.number,
          onChanged: (input) {
            // Reformat the input and update the field
            final formatted = _reformatInput(input);
            final parsedDuration = _parseDuration(formatted);

            _controller.value = _controller.value.copyWith(
              text: formatted,
            );

            setstate(() {});

            updateField(
              context,
              group,
              parsedDuration,
            );
          },
        );
      },
    );
  }

  // Formats Duration object into '00d 00h 00m 00s'
  String _formatDuration(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${days.toString().padLeft(2, '0')}d ${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
  }

  // Parses the input into a Duration object
  Duration _parseDuration(String input) {
    final regex = RegExp(r'(\d+)d (\d{2})h (\d{2})m (\d{2})s');
    final match = regex.firstMatch(input);

    if (match != null) {
      final days = int.parse(match.group(1)!);
      final hours = int.parse(match.group(2)!);
      final minutes = int.parse(match.group(3)!);
      final seconds = int.parse(match.group(4)!);
      return Duration(
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
      );
    } else {
      return Duration.zero;
    }
  }

  String _reformatInput(String input) {
    // Remove non-numeric characters
    input = input.replaceAll(RegExp(r'[^0-9]'), '');

    // Pad input with leading zeros to ensure it has at least 8 characters
    input = input.padLeft(8, '0');

    // Split the input into chunks from the end for days, hours, minutes, seconds
    String seconds = input.substring(input.length - 2);
    String minutes = input.substring(input.length - 4, input.length - 2);
    String hours = input.substring(input.length - 6, input.length - 4);
    String days = input.substring(0, input.length - 6);

    return '${days}d ${hours}h ${minutes}m ${seconds}s';
  }
}
