import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import '../settings/settings.dart';
import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

typedef LabelBuilder<T> = String Function(T value);

/// [Field] that builds [DropdownSetting] for [List]<[T]> values.
class ListField<T> extends Field<T> {
  ListField({
    required super.name,
    required this.values,
    required super.initialValue,
    this.labelBuilder,
    super.onChanged,
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
  Widget toWidget(BuildContext context, String group, T? value) {
    return DropdownSetting<T>(
      options: values,
      initialSelection: value,
      optionValueBuilder: labelBuilder,
      onSelected: (value) => updateField(context, group, value),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'values': values.map((codec.toParam)).toList(),
    };
  }
}
