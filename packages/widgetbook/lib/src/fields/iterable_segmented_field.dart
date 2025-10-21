import 'dart:convert';

import 'package:flutter/material.dart';

import '../../widgetbook.dart';

/// A [Field] that builds [SegmentedButton]<[Iterable<T>]> for [Iterable] values.
class IterableSegmentedField<T> extends Field<Iterable<T>> {
  /// Creates a new instance of [IterableSegmentedField].
  IterableSegmentedField({
    required super.name,
    required this.values,
    required super.initialValue,
    this.labelBuilder = defaultLabelBuilder,
    this.multiSelectionEnabled = true,
    this.emptySelectionAllowed = true,
    this.style,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         defaultValue: values,
         type: FieldType.iterableSegmented,
         codec: FieldCodec(
           toParam: (params) => jsonEncode(params.map(labelBuilder).toList()),
           toValue: (param) {
             if (param == null) return null;
             final result = values.where((value) {
               try {
                 return (jsonDecode(param) as List<dynamic>).contains(
                   labelBuilder(value),
                 );
               } catch (_) {
                 return false;
               }
             });
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

  /// Whether multiple selection is enabled.
  final bool multiSelectionEnabled;

  /// Whether empty selection is allowed. InitialOption must not be empty if this is false.
  final bool emptySelectionAllowed;

  /// The style of the segmented button.
  final ButtonStyle? style;

  @override
  Widget toWidget(BuildContext context, String group, Iterable<T>? value) {
    return SegmentedButton<T>(
      style: style,
      selected: value?.toSet() ?? {},
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
    return {'values': codec.toParam(values)};
  }
}
