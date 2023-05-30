import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

/// [Field] that builds [Slider] for [double] values.
class DoubleSliderField extends Field<double> {
  DoubleSliderField({
    required super.group,
    required super.name,
    super.initialValue = 0,
    required this.min,
    required this.max,
    this.divisions,
    required super.onChanged,
  }) : super(
          type: FieldType.doubleSlider,
          codec: FieldCodec(
            toParam: (value) => value.toString(),
            toValue: (param) => double.tryParse(param ?? ''),
          ),
        );

  final double min;
  final double max;
  final int? divisions;

  @override
  Widget toWidget(BuildContext context, double? value) {
    return Slider(
      value: value ?? initialValue ?? 0,
      min: min,
      max: max,
      label: (value ?? initialValue ?? 0).toStringAsFixed(2),
      divisions: divisions,
      onChanged: (value) => updateField(context, value),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'min': min,
      'max': max,
      'divisions': divisions,
    };
  }
}
