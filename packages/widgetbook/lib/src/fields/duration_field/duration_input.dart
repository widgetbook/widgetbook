import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../common/number_text_field.dart';
import 'duration_unit.dart';

@internal
class DurationInput extends StatefulWidget {
  const DurationInput({
    super.key,
    required this.value,
    required this.units,
    required this.onChanged,
  });

  final Duration value;
  final Set<DurationUnit> units;
  final ValueChanged<Duration> onChanged;

  @override
  State<DurationInput> createState() => _DurationInputState();
}

class _DurationInputState extends State<DurationInput> {
  /// The current value of each enabled unit, keyed by unit.
  late Map<DurationUnit, int> values;

  @override
  void initState() {
    super.initState();
    values = _decompose(widget.value);
  }

  /// The largest enabled unit; it absorbs everything above the next-smaller
  /// enabled unit and therefore accepts arbitrarily large values.
  DurationUnit get _largestUnit =>
      DurationUnit.values.firstWhere(widget.units.contains);

  /// Splits [value] into a count per enabled unit, walking from largest to
  /// smallest so that the largest enabled unit holds the overflow and nothing
  /// is silently dropped when high-order units are disabled.
  Map<DurationUnit, int> _decompose(Duration value) {
    final result = <DurationUnit, int>{};
    var remaining = value.inMicroseconds;
    for (final unit in DurationUnit.values) {
      if (!widget.units.contains(unit)) continue;
      final step = unit.step.inMicroseconds;
      final count = remaining ~/ step;
      result[unit] = count;
      remaining -= count * step;
    }
    return result;
  }

  void _onUnitChanged(DurationUnit unit, int newValue) {
    setState(() {
      values[unit] = newValue;
    });

    var total = Duration.zero;
    values.forEach((unit, value) {
      total += unit.step * value;
    });
    widget.onChanged(total);
  }

  /// Bounds smaller units to their natural range (e.g. 0-59, 0-999) so they
  /// don't overflow into a unit that is shown separately. The largest enabled
  /// unit is left unbounded so it can represent the full duration.
  List<TextInputFormatter> _formattersFor(DurationUnit unit) {
    final boundedPattern = switch (unit) {
      DurationUnit.minutes || DurationUnit.seconds => r'^[0-5]?[0-9]$',
      DurationUnit.milliseconds || DurationUnit.microseconds => r'^[0-9]{0,3}$',
      _ => null,
    };

    if (unit == _largestUnit || boundedPattern == null) {
      return [FilteringTextInputFormatter.digitsOnly];
    }

    return [
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.allow(
        RegExp(boundedPattern),
        replacementString: '${values[unit] ?? 0}',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        for (final unit in DurationUnit.values)
          if (widget.units.contains(unit))
            Expanded(
              child: NumberTextField(
                value: values[unit] ?? 0,
                maxLength: unit == _largestUnit ? 6 : unit.maxLength,
                inputFormatters: _formattersFor(unit),
                labelText: unit.label,
                onChanged: (value) => _onUnitChanged(unit, value),
              ),
            ),
      ],
    );
  }
}
