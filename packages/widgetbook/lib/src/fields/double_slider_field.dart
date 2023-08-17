import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

/// [Field] that builds [Slider] for [double] values.
class DoubleSliderField extends Field<double> {
  DoubleSliderField({
    required super.name,
    super.initialValue = 0,
    required this.min,
    required this.max,
    this.divisions,
    super.onChanged,
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
  Widget toWidget(BuildContext context, String group, double? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 8,
          child: Slider(
            value: value ?? 0,
            min: min,
            max: max,
            label: (value ?? 0).toStringAsFixed(2),
            divisions: divisions,
            onChanged: (value) => updateField(context, group, value),
          ),
        ),
        Expanded(
          child: Text(
            value?.toStringAsFixed(2) ?? '',
            textAlign: TextAlign.end,
            maxLines: 1,
          ),
        ),
      ],
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
