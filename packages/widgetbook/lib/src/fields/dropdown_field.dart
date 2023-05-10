import 'package:flutter/widgets.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../state/state.dart';
import 'field.dart';
import 'field_type.dart';

class DropdownField<T> extends Field<T> {
  DropdownField({
    required super.group,
    required super.name,
    required this.values,
    required super.initialValue,
    required this.labelBuilder,
    required super.codec,
    required super.onChanged,
  }) : super(
          type: FieldType.dropdown,
        );

  final List<T> values;
  final String Function(T value) labelBuilder;

  @override
  Widget buildField(BuildContext context, T? value) {
    return DropdownSetting<T>(
      options: values,
      initialSelection: value,
      optionValueBuilder: labelBuilder,
      onSelected: (value) => updateField(context, value),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'values': values.map((codec.toParam)).toList(),
    };
  }
}
