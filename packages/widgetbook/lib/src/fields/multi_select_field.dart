import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

typedef FieldLabelBuilder<T> = String Function(T value);

class MultiSelectField<T> extends Field<List<T>> {
  MultiSelectField({
    required super.name,
    required this.values,
    required super.initialValue,
    this.labelBuilder = defaultLabelBuilder,
    @deprecated super.onChanged,
  }) : super(
          type: FieldType.multiSelect,
          codec: FieldCodec(
            toParam: (value) => value.map(labelBuilder).join(','),
            toValue: (param) {
              final selectedValues = param?.split(',') ?? [];
              return values
                  .where(
                    (value) => selectedValues.contains(labelBuilder(value)),
                  )
                  .toList();
            },
          ),
        );

  final List<T> values;
  final FieldLabelBuilder<T> labelBuilder;

  static String defaultLabelBuilder(dynamic value) {
    return value.toString();
  }

  @override
  Widget toWidget(BuildContext context, String group, List<T>? value) {
    final selectedValues = value ?? initialValue ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: values.map((option) {
        final isSelected = selectedValues.contains(option);
        return CheckboxListTile(
          value: isSelected,
          title: Text(labelBuilder(option)),
          onChanged: (selected) {
            if (selected == true) {
              selectedValues.add(option);
            } else {
              selectedValues.remove(option);
            }
            updateField(context, group, selectedValues);
          },
        );
      }).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'values': codec.toParam(values),
    };
  }
}
