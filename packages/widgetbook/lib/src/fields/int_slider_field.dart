import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';
import 'num_slider_field.dart';

/// A [Field] that builds [Slider] for [int] values.
class IntSliderField extends NumSliderField<int> {
  /// Creates a new instance of [IntSliderField].
  IntSliderField({
    required super.name,
    super.initialValue = 0,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
    required super.min,
    required super.max,
    this.divisions,
  }) : super(
         type: FieldType.intSlider,
         codec: FieldCodec<int>(
           toParam: (value) => value.toString(),
           toValue: (param) => double.tryParse(param ?? '')?.round(),
         ),
       );

  final int? divisions;
}
