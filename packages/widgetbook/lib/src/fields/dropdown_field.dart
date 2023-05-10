import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../state/state.dart';
import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

typedef LabelBuilder<T> = String Function(T value);

class DropdownField<T> extends Field<T> {
  DropdownField({
    required super.group,
    required super.name,
    required this.values,
    required super.initialValue,
    this.labelBuilder,
    required super.onChanged,
  }) : super(
          type: FieldType.dropdown,
          codec: FieldCodec(
            toParam: (item) {
              return labelBuilder == null
                  ? item.toString()
                  : labelBuilder(item);
            },
            toValue: (param) => param == null
                ? null
                : values.firstWhereOrNull(
                    (item) {
                      final label = labelBuilder == null
                          ? item.toString()
                          : labelBuilder(item);
                      return label == param;
                    },
                  ),
          ),
        );

  final List<T> values;
  final LabelBuilder<T>? labelBuilder;

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
