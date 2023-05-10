import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class SliderField extends Field<double> {
  SliderField({
    required super.group,
    required super.name,
    super.initialValue = 0,
    required this.min,
    required this.max,
    this.divisions,
    required super.onChanged,
  }) : super(
          type: FieldType.text,
          codec: FieldCodec(
            toParam: (value) => value.toString(),
            toValue: (param) => double.tryParse(param ?? ''),
          ),
        );

  final double min;
  final double max;
  final int? divisions;

  @override
  Widget buildField(BuildContext context, double? value) {
    return Slider(
      value: value ?? initialValue,
      min: min,
      max: max,
      label: (value ?? initialValue).toStringAsFixed(2),
      divisions: divisions,
      onChanged: (value) => updateField(context, value),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'value': initialValue,
      'min': min,
      'max': max,
      'divisions': divisions,
    };
  }
}
