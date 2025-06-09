import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../widgetbook.dart';


/// [Field] that builds [SegmentButton]<[T]> for [List]<[T]> values.
class SegmentButton<T> extends Field<T> {
  SegmentButton({
    required super.name,
    required this.values,
    required super.initialValue,
    this.labelBuilder = defaultLabelBuilder,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
          type: FieldType.segmentButton,
          codec: FieldCodec(
            toParam: labelBuilder,
            toValue: (param) => values.firstWhereOrNull(
              (value) => labelBuilder(value) == param,
            ),
          ),
        );

  final List<T> values;
  final LabelBuilder<T> labelBuilder;

  static String defaultLabelBuilder(dynamic value) {
    return value.toString();
  }

  @override
  Widget toWidget(BuildContext context, String group, T? value) {
    return SegmentedButton<T>(
      segments: values
          .map(
            (value) => ButtonSegment<T>(
              value: value,
              label: Text(labelBuilder(value)),
            ),
          )
          .toList(),
      selected: value != null ? {value} : {},
      onSelectionChanged: ( newValue) {
        if (newValue.isNotEmpty) {
          updateField(context, group, newValue.first);
        }
      },
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'values': values.map((codec.toParam)).toList(),
    };
  }
}
