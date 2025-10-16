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
    required super.toParam,
    required super.toValue,
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
  Widget toWidget(BuildContext context, String groupName, T value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 8,
          child: Slider(
            value: value.toDouble().clamp(min.toDouble(), max.toDouble()),
            min: min.toDouble(),
            max: max.toDouble(),
            label: toParam(value),
            divisions: divisions,
            onChanged: (value) {
              return updateField(
                context,
                groupName,
                toValue(value.toString())!,
              );
            },
          ),
        ),
        Expanded(
          child: Text(
            toParam(value),
            textAlign: TextAlign.end,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
