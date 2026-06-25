part of '../field.dart';

/// A [Field] that represents a [Duration] value.
final class DurationField extends Field<Duration> {
  /// Creates a new instance of [DurationField].
  DurationField({
    required super.name,
    super.initialValue = defaultDuration,
    this.units = DurationUnit.defaults,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : assert(units.isNotEmpty, 'At least one DurationUnit must be enabled.'),
       super(
         toParam: (value) => value.inMilliseconds.toString(),
         toValue: (param) {
           final ms = int.tryParse(param);
           if (ms == null) return null;
           return Duration(milliseconds: ms);
         },
       );

  /// The default duration value used when no initial value is provided.
  static const defaultDuration = Duration.zero;

  /// The time units displayed as separate inputs, rendered from largest to
  /// smallest. Defaults to [DurationUnit.defaults].
  final Set<DurationUnit> units;

  @override
  Widget toWidget(BuildContext context, String groupName, Duration value) {
    return DurationInput(
      value: value,
      units: units,
      onChanged: (duration) {
        updateField(context, groupName, duration);
      },
    );
  }
}
