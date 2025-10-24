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
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         defaultValue: values,
         type: FieldType.iterableSegmented,
         codec: FieldCodec(
           toParam: (value) => "[${value.map(labelBuilder).join(',')}]",
           toValue: (param) {
             if (param == null) return null;
             if (!param.startsWith('[') || !param.endsWith(']')) {
               throw Exception(
                 'Invalid parameter format: $param. Expected format: [item1,item2,...]',
               );
             }

             final parsedParam = param.substring(1, param.length - 1);
             if (parsedParam.isEmpty) return [];

             return parsedParam
                 .split(',')
                 .map(
                   (item) => values.firstWhere(
                     (value) => labelBuilder(value) == item,
                     orElse:
                         () =>
                             throw Exception(
                               'Value with label "$item" not found in available values.',
                             ),
                   ),
                 );
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

  @override
  Widget toWidget(BuildContext context, String group, Iterable<T>? value) {
    return SegmentedButton<T>(
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
