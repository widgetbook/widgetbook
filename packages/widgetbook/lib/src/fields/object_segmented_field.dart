import 'dart:convert';

import 'package:flutter/material.dart';

import '../../widgetbook.dart';

/// A [Field] that builds [SegmentedButton]<[T]> for [Object] values.
class ObjectSegmentedField<T> extends Field<Set<T>> {
  /// Creates a new instance of [ObjectSegmentedField].
  ObjectSegmentedField({
    required super.name,
    required this.values,
    required super.initialValue,
    this.labelBuilder = defaultLabelBuilder,
    this.multiSelectionEnabled = true,
    this.emptySelectionAllowed = true,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         defaultValue: values,
         type: FieldType.objectSegmented,
         codec: FieldCodec(
           toParam: (params) => jsonEncode(params.map(labelBuilder).toList()),
           toValue: (param) {
             if (param == null) return null;
             final result =
                 values.where((value) {
                   try {
                     return (jsonDecode(param) as List<dynamic>).contains(
                       labelBuilder(value),
                     );
                   } catch (_) {
                     return false;
                   }
                 }).toSet();
             if (result.isEmpty) return null;
             return result;
           },
         ),
       );

  /// The list of values to display in the segmented button.
  final Set<T> values;

  /// The function to build the label for each value in the segmented button.
  final LabelBuilder<T> labelBuilder;

  /// The default label builder that converts the value to a string.
  static String defaultLabelBuilder(dynamic value) {
    return value.toString();
  }

  /// Whether multiple selection is enabled.
  final bool multiSelectionEnabled;

  /// Whether empty selection is allowed. InitialOption must not be empty if this is false.
  final bool emptySelectionAllowed;

  @override
  Widget toWidget(BuildContext context, String group, Set<T>? value) {
    return SegmentedButton<T>(
      style:
          Theme.of(context).segmentedButtonTheme.style ??
          SegmentedButton.styleFrom(padding: EdgeInsets.zero),
      selected: value ?? {},
      multiSelectionEnabled: multiSelectionEnabled,
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
    return {
      'values': codec.toParam(values),
    };
  }
}
