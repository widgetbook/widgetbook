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

  Size _getTextSize(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size;
  }

  @override
  Widget toWidget(BuildContext context, String group, T? value) {
    final defaultValue = (T == int ? 0 : 0.0) as T;
    final label = codec.toParam(value ?? initialValue ?? defaultValue);
    final minLabel = codec.toParam(min);
    final maxLabel = codec.toParam(max);

    final textStyle = DefaultTextStyle.of(context).style;
    final minSize = _getTextSize(minLabel, textStyle);
    final maxSize = _getTextSize(maxLabel, textStyle);
    final widestSize = minSize.width > maxSize.width ? minSize : maxSize;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing:
          SliderTheme.of(context).overlayShape == SliderComponentShape.noThumb
          ? 16
          : 0,
      children: [
        Expanded(
          child: Slider(
            value: ((value ?? initialValue)?.toDouble() ?? 0).clamp(
              min.toDouble(),
              max.toDouble(),
            ),
            min: min.toDouble(),
            max: max.toDouble(),
            label: label,
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
        SizedBox(
          width: widestSize.width,
          child: Text(
            label,
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
