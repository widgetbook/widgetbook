import 'package:flutter/material.dart';

import 'field.dart';

class NumSliderField<T extends num> extends Field<T> {
  NumSliderField({
    required super.name,
    this.divisions,
    super.initialValue,
    super.onChanged,
    required this.min,
    required this.max,
    required super.codec,
    required super.type,
  }) : assert(
          initialValue == null || (initialValue >= min && initialValue <= max),
        );

  final T min;
  final T max;
  final int? divisions;

  @override
  Widget toWidget(BuildContext context, String group, T? value) {
    final defaultValue = (T == int ? 0 : 0.0) as T;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 8,
          child: Slider(
            value: (value ?? initialValue)?.toDouble() ?? 0,
            min: min.toDouble(),
            max: max.toDouble(),
            label: codec.toParam(value ?? initialValue ?? defaultValue),
            divisions: divisions,
            onChanged: (value) {
              return updateField(
                context,
                group,
                codec.toValue(value.toString())!,
              );
            },
          ),
        ),
        Expanded(
          child: Text(
            codec.toParam(value ?? initialValue ?? defaultValue),
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
