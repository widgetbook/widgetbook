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
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         type: FieldType.doubleSlider,
         codec: FieldCodec(
           toParam: (value) => value.toString(),
           toValue: (param) => double.tryParse(param ?? ''),
         ),
       );

  final int? divisions;
}
