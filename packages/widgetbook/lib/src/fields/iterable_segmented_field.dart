import 'package:flutter/material.dart';

import 'fields.dart';

/// A [Field] that builds [SegmentedButton]<[Iterable<T>]> for [Iterable] values.
class IterableSegmentedField<T> extends Field<Iterable<T>> {
  /// Creates a new instance of [IterableSegmentedField].
  IterableSegmentedField({
    required super.name,
    required this.values,
    required super.initialValue,
    this.labelBuilder = defaultLabelBuilder,
    this.emptySelectionAllowed = true,
    this.style,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         defaultValue: values,
         type: FieldType.iterableSegmented,
         codec: FieldCodec(
           toParam:
               (params) => "[${params.map(labelBuilder).toList().join(',')}]",
           toValue: (params) {
             if (params == null) return null;
             if (!params.startsWith('[') && !params.endsWith(']')) return null;
             params = params.substring(1, params.length - 1);
             final list = params.split(',');
             final result = values.where(
               (value) => list.contains(labelBuilder(value)),
             );
             if (result.isEmpty) return null;
             return result;
           },
         ),
       );

  /// The list of values to display in the segmented button.
  final Iterable<T> values;

  /// The function to build the label for each value in the segmented button.
  final LabelBuilder<T> labelBuilder;

  /// The default label builder that converts the value to a string.
  static String defaultLabelBuilder(dynamic value) {
    return value.toString();
  }

  /// Whether empty selection is allowed. InitialOption must not be empty if this is false.
  final bool emptySelectionAllowed;

  /// The style of the segmented button.
  final ButtonStyle? style;

  @override
  Widget toWidget(BuildContext context, String group, Iterable<T>? value) {
    return SegmentedButton<T>(
      style: style,
      selected: value?.toSet() ?? {},
      multiSelectionEnabled: true,
      emptySelectionAllowed: emptySelectionAllowed,
      onSelectionChanged: (newValue) {
        updateField(context, group, newValue);
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
    return {'values': codec.toParam(values)};
  }
}
