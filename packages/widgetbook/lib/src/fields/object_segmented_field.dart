import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../widgetbook.dart';

/// A [Field] that builds [SegmentedButton]<[T]> for [Object] values.
class ObjectSegmentedField<T> extends Field<T> {
  /// Creates a new instance of [ObjectSegmentedField].
  ObjectSegmentedField({
    required super.name,
    required this.values,
    required super.initialValue,
    this.labelBuilder = defaultLabelBuilder,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         defaultValue: values.first,
         type: FieldType.objectSegmented,
         codec: FieldCodec(
           toParam: labelBuilder,
           toValue:
               (param) => values.firstWhereOrNull(
                 (value) => labelBuilder(value) == param,
               ),
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
  Widget toWidget(BuildContext context, String group, T? value) {
    return SegmentedButton<T>(
      selected: value != null ? {value} : {},
      emptySelectionAllowed: value == null,
      onSelectionChanged: (newValue) {
        if (newValue.isNotEmpty) {
          updateField(context, group, newValue.first);
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'values': values.map((codec.toParam)).toList(),
    };
  }
}
