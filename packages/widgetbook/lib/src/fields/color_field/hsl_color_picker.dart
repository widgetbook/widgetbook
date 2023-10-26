import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'number_text_field.dart';

class HslColorPicker extends StatefulWidget {
  const HslColorPicker({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final Color value;
  final ValueChanged<Color> onChanged;

  @override
  State<HslColorPicker> createState() => _HslColorPickerState();
}

class _HslColorPickerState extends State<HslColorPicker> {
  late double hue;
  late double saturation;
  late double lightness;

  HSLColor get color => HSLColor.fromAHSL(
        widget.value.alpha / 255,
        hue,
        saturation / 100,
        lightness / 100,
      );

  @override
  void initState() {
    super.initState();

    final hslColor = HSLColor.fromColor(widget.value);
    hue = hslColor.hue;
    saturation = hslColor.saturation * 100;
    lightness = hslColor.lightness * 100;
  }

  void onValueChanged(
    double newHue,
    double newSaturation,
    double newLightness,
  ) {
    setState(() {
      hue = newHue;
      saturation = newSaturation;
      lightness = newLightness;
    });

    final newColor = HSLColor.fromAHSL(
      color.alpha,
      newHue,
      newSaturation / 100,
      newLightness / 100,
    );

    widget.onChanged.call(newColor.toColor());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: NumberTextField(
            value: '${hue.toInt()}',
            maxLength: 3,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^(?:[0-9]\d?|[12]\d{2}|3[0-5]\d)$'),
                replacementString: '${hue.toInt()}',
              ),
            ],
            labelText: 'H',
            onChanged: (value) {
              onValueChanged(
                double.tryParse(value) ?? hue,
                saturation,
                lightness,
              );
            },
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: NumberTextField(
            value: '${saturation.round()}',
            maxLength: 3,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^(0|[1-9][0-9]?|100)$'),
                replacementString: '${saturation.round()}',
              ),
            ],
            labelText: 'S',
            suffixText: '%',
            onChanged: (value) {
              onValueChanged(
                hue,
                double.tryParse(value) ?? saturation,
                lightness,
              );
            },
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: NumberTextField(
            value: '${lightness.round()}',
            maxLength: 3,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^(0|[1-9][0-9]?|100)$'),
                replacementString: '${lightness.round()}',
              ),
            ],
            labelText: 'L',
            suffixText: '%',
            onChanged: (value) {
              onValueChanged(
                hue,
                saturation,
                double.tryParse(value) ?? lightness,
              );
            },
          ),
        ),
      ],
    );
  }
}
