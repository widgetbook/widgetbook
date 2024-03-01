import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

typedef LabelBuilder<T> = String Function(T value);

/// [Field] that builds [DropdownMenu]<[T]> for [List]<[T]> values.
class ListField<T> extends Field<T> {
  ListField({
    required super.name,
    required this.values,
    required super.initialValue,
    this.labelBuilder = defaultLabelBuilder,
    @deprecated super.onChanged,
  }) : super(
          type: FieldType.list,
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
    return DropdownMenu<T>(
      trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
      initialSelection: value ?? values.first,
      onSelected: (value) {
        if (value != null) {
          updateField(context, group, value);
        }
      },
      dropdownMenuEntries: values
          .map(
            (value) => DropdownMenuEntry(
              value: value,
              label: labelBuilder(value),
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
