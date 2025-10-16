import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'field.dart';
import 'object_dropdown_field.dart';

/// A [Field] that builds [SegmentedButton]<[T]> for [Object] values.
class ObjectSegmentedField<T> extends Field<T> {
  /// Creates a new instance of [ObjectSegmentedField].
  ObjectSegmentedField({
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

  /// The list of values to display in the segmented button.
  final List<T> values;

  /// The function to build the label for each value in the segmented button.
  final LabelBuilder<T> labelBuilder;

  /// The default label builder that converts the value to a string.
  static String defaultLabelBuilder(dynamic value) {
    return value.toString();
  }

  @override
  Widget toWidget(BuildContext context, String groupName, T value) {
    return SegmentedButton<T>(
      selected: value != null ? {value} : {},
      emptySelectionAllowed: value == null,
      onSelectionChanged: (newValue) {
        if (newValue.isNotEmpty) {
          updateField(context, groupName, newValue.first);
        }
      },
      segments:
          values
              .map(
                (value) => ButtonSegment<T>(
                  value: value,
                  label: Text(labelBuilder(value)),
                ),
              )
              .toList(),
    );
  }
}
