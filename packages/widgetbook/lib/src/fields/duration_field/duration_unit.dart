/// A single time unit that a [Duration] can be broken down into and edited
/// through, used by the duration knob to decide which inputs to display.
///
/// The declaration order (largest to smallest) is also the order in which the
/// inputs are rendered and the order in which a [Duration] is decomposed: the
/// largest enabled unit absorbs everything above the next-smaller enabled unit,
/// so no part of the value is ever hidden.
enum DurationUnit {
  /// Days component, labelled `d`.
  days(step: Duration(days: 1), label: 'd', maxLength: 6),

  /// Hours component, labelled `h`.
  hours(step: Duration(hours: 1), label: 'h', maxLength: 6),

  /// Minutes component, labelled `m`.
  minutes(step: Duration(minutes: 1), label: 'm', maxLength: 2),

  /// Seconds component, labelled `s`.
  seconds(step: Duration(seconds: 1), label: 's', maxLength: 2),

  /// Milliseconds component, labelled `ms`.
  milliseconds(step: Duration(milliseconds: 1), label: 'ms', maxLength: 3),

  /// Microseconds component, labelled `µs`.
  microseconds(step: Duration(microseconds: 1), label: 'µs', maxLength: 3);

  const DurationUnit({
    required this.step,
    required this.label,
    required this.maxLength,
  });

  /// The size of a single increment of this unit (e.g. `Duration(hours: 1)`).
  final Duration step;

  /// Short label shown above the input field (e.g. `h` for [hours]).
  final String label;

  /// Maximum number of digits the input field accepts for this unit when it is
  /// not the largest enabled unit.
  final int maxLength;

  /// The units shown by default: hours, minutes and seconds.
  static const Set<DurationUnit> defaults = {hours, minutes, seconds};
}
