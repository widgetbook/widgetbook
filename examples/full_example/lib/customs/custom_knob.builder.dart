// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint

// **************************************************************************
// BuilderGenerator
// **************************************************************************

part of 'custom_knob.dart';

Widget rangeSliderGenerated(BuildContext context) {
  {
    return RangeSlider(
      values: context.knobs.range(label: 'Range'),
      max: 10,
      min: 1,
      onChanged: (_) {},
    );
  }
}
