import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';
import 'num_slider_field.dart';

/// A [Field] that builds [Slider] for [double] values.
class DoubleSliderField extends NumSliderField<double> {
  /// Creates a new instance of [DoubleSliderField].
  DoubleSliderField({
    required super.name,
    super.initialValue = 0,
    required super.min,
    required super.max,
    this.divisions,
    this.precision = 1,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         type: FieldType.doubleSlider,
         codec: FieldCodec(
           toParam: (value) {
             if (precision != null) return value.toStringAsFixed(precision);
             return value.toString();
           },
           toValue: (param) => double.tryParse(param ?? ''),
         ),
       );

  final int? divisions;

  /// The number of decimal places to display and return.
  final int? precision;
}
