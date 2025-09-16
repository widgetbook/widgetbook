import 'package:flutter/material.dart';

import 'field.dart';

/// A base class for [Field]s that represent [num] values using a slider.
class NumSliderField<T extends num> extends Field<T> {
  /// Creates a new instance of [NumSliderField].
  NumSliderField({
    required super.name,
    this.divisions,
    super.initialValue,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
    required this.min,
    required this.max,
    required super.codec,
    required super.type,
  }) : assert(
         initialValue == null || (initialValue >= min && initialValue <= max),
       ),
       super(defaultValue: min);

  /// The minimum value of the slider.
  final T min;

  /// The maximum value of the slider.
  final T max;

  /// The number of discrete divisions in the slider.
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
            value: ((value ?? initialValue)?.toDouble() ?? 0).clamp(
              min.toDouble(),
              max.toDouble(),
            ),
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
