import 'package:flutter/widgets.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import 'field.dart';
import 'field_type.dart';

class ListField<T> extends Field<T> {
  final List<T> values;
  final T? value;
  final String Function(T value) labelBuilder;

  ListField({
    required super.name,
    required this.values,
    this.value,
    required this.labelBuilder,
    required super.onChanged,
  }) : super(
          type: FieldType.list,
        );

  @override
  Widget build(BuildContext context) {
    return DropdownSetting<T>(
      options: values,
      initialSelection: value,
      optionValueBuilder: labelBuilder,
      onSelected: onChanged,
    );
  }
}
