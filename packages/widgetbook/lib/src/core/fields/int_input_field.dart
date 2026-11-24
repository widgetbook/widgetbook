part of 'field.dart';

/// A [Field] that builds [TextFormField] for [int] values.
final class IntInputField extends NumInputField<int> {
  /// Creates a new instance of [IntInputField].
  IntInputField({
    required super.name,
    super.initialValue = 0,
  }) : super(
         formatters: [
           FilteringTextInputFormatter.allow(
             RegExp(r'^-?\d*'),
           ),
         ],
       );
}
