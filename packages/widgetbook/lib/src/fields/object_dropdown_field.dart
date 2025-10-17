part of 'field.dart';

/// A [Field] that builds [DropdownMenu]<[T]> for [Object] values.
final class ObjectDropdownField<T> extends Field<T> {
  /// Creates a new instance of [ObjectDropdownField].
  ObjectDropdownField({
    required super.name,
    required this.values,
    T? initialValue,
    this.labelBuilder = defaultLabelBuilder,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         initialValue: initialValue ?? values.first,
         toParam: labelBuilder,
         toValue:
             (param) => values.firstWhereOrNull(
               (value) => labelBuilder(value) == param,
             ),
       );

  /// The list of values to display in the dropdown.
  final List<T> values;

  /// The function to build the label for each value in the dropdown.
  final LabelBuilder<T> labelBuilder;

  /// The default label builder that converts the value to a string.
  static String defaultLabelBuilder(dynamic value) {
    return value.toString();
  }

  @override
  Widget toWidget(BuildContext context, String groupName, T value) {
    return DropdownMenu<T>(
      expandedInsets: EdgeInsets.zero,
      trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
      initialSelection: value,
      onSelected: (value) {
        if (value != null) {
          updateField(context, groupName, value);
        }
      },
      dropdownMenuEntries:
          values
              .map(
                (value) => DropdownMenuEntry(
                  value: value,
                  label: labelBuilder(value),
                ),
              )
              .toList(),
    );
  }
}
