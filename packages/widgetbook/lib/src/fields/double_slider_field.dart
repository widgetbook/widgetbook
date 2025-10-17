part of 'field.dart';

/// A [Field] that builds [Slider] for [double] values.
final class DoubleSliderField extends NumSliderField<double> {
  /// Creates a new instance of [DoubleSliderField].
  DoubleSliderField({
    required super.name,
    super.initialValue = 0,
    required super.min,
    required super.max,
    this.divisions,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         toParam: (value) => value.toString(),
         toValue: double.tryParse,
       );

  final int? divisions;
}
