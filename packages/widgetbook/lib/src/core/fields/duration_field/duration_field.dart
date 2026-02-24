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
