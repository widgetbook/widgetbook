part of 'field.dart';

/// A base class for [Field]s that represent [num] values using a [TextField].
sealed class NumInputField<T extends num> extends Field<T> {
  /// Creates a new instance of [NumInputField].
  NumInputField({
    required super.name,
    T? initialValue,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
    required this.formatters,
  }) : super(
         initialValue: initialValue ?? (T == int ? 0 as T : 0.0 as T),
         toParam: (value) => value.toString(),
         toValue: (param) => num.tryParse(param) as T?,
       );

  /// The list of input formatters to apply to the text input.
  final List<TextInputFormatter> formatters;

  @override
  Widget toWidget(BuildContext context, String groupName, T value) {
    return ControlledTextField(
      initialValue: toParam(value),
      keyboardType: TextInputType.number,
      inputFormatters: formatters,
      decoration: const InputDecoration(
        hintText: 'Enter a number',
      ),
      onChanged: (value) {
        final number = toValue(value);
        if (number == null) return;

        updateField(context, groupName, number);
      },
    );
  }
}
