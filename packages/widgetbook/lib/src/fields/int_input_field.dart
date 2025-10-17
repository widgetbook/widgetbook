part of 'field.dart';

/// A [Field] that builds [TextFormField] for [int] values.
final class IntInputField extends NumInputField<int> {
  /// Creates a new instance of [IntInputField].
  IntInputField({
    required super.name,
    super.initialValue = 0,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         formatters: [
           FilteringTextInputFormatter.allow(
             RegExp(r'^-?\d*'),
           ),
         ],
       );
}
