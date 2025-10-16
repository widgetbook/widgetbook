import 'package:flutter/material.dart';

import 'field.dart';

/// A base class for [Field]s that represent [num] values using a slider.
class NumSliderField<T extends num> extends Field<T> {
  /// Creates a new instance of [NumSliderField].
  NumSliderField({
    required super.name,
    this.divisions,
    T? initialValue,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
    required this.min,
    required this.max,
    required super.codec,
  }) : assert(
         initialValue == null || (initialValue >= min && initialValue <= max),
       ),
       super(initialValue: initialValue ?? min);

  /// The minimum value of the slider.
  final T min;

  /// The maximum value of the slider.
  final T max;

  /// The number of discrete divisions in the slider.
  final int? divisions;

  @override
  Widget toWidget(BuildContext context, String groupName, T? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 8,
          child: Slider(
            value: ((value ?? initialValue).toDouble()).clamp(
              min.toDouble(),
              max.toDouble(),
            ),
            min: min.toDouble(),
            max: max.toDouble(),
            label: codec.toParam(value ?? initialValue),
            divisions: divisions,
            onChanged: (value) {
              return updateField(
                context,
                groupName,
                codec.toValue(value.toString())!,
              );
            },
          ),
        ),
        Expanded(
          child: Text(
            codec.toParam(value ?? initialValue),
            textAlign: TextAlign.end,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
