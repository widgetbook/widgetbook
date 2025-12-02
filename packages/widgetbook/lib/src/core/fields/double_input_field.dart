part of 'field.dart';

/// A [Field] that builds [TextFormField] for [double] values.
final class DoubleInputField extends NumInputField<double> {
  /// Creates a new instance of [DoubleInputField].
  DoubleInputField({
    required super.name,
    super.initialValue = 0,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         formatters: [
           FilteringTextInputFormatter.allow(
             RegExp(r'^-?\d*\.?\d*'),
           ),
         ],
       );
}
