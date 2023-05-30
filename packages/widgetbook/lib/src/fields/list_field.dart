import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

typedef LabelBuilder<T> = String Function(T value);

/// [Field] that builds [DropdownSetting] for [List]<[T]> values.
class ListField<T> extends Field<T> {
  ListField({
    required super.group,
    required super.name,
    required this.values,
    required super.initialValue,
    this.labelBuilder,
    required super.onChanged,
  }) : super(
          type: FieldType.list,
          codec: FieldCodec(
            toParam: (value) {
              return labelBuilder == null
                  ? value.toString()
                  : labelBuilder(value);
            },
            toValue: (param) => param == null
                ? null
                : values.firstWhereOrNull(
                    (value) {
                      final label = labelBuilder == null
                          ? value.toString()
                          : labelBuilder(value);
                      return label == param;
                    },
                  ),
          ),
        );

  final List<T> values;
  final LabelBuilder<T>? labelBuilder;

  @override
  Widget toWidget(BuildContext context, T? value) {
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
