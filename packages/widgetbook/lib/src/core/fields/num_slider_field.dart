part of 'field.dart';

/// A base class for [Field]s that represent [num] values using a slider.
sealed class NumSliderField<T extends num> extends Field<T> {
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

  Size _getTextSize(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size;
  }

  @override
  Widget toWidget(BuildContext context, String groupName, T value) {
    final label = toParam(value);
    final maxLabel = toParam(max);
    final minLabel = toParam(min);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing:
          SliderTheme.of(context).overlayShape == SliderComponentShape.noThumb
          ? 16
          : 0,
      children: [
        Expanded(
          child: Slider(
            value: value.toDouble().clamp(min.toDouble(), max.toDouble()),
            min: min.toDouble(),
            max: max.toDouble(),
            label: label,
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
        SizedBox(
          width: _getTextSize(
            // Min label can be larger than max in case of negative numbers
            maxLabel.length > minLabel.length ? maxLabel : minLabel,
            DefaultTextStyle.of(context).style,
          ).width,
          child: Text(
            label,
            textAlign: TextAlign.end,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
