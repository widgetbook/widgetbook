import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'number_text_field.dart';

class HslColorPicker extends StatefulWidget {
  const HslColorPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final Color value;
  final ValueChanged<Color> onChanged;

  @override
  State<HslColorPicker> createState() => _HslColorPickerState();
}

class _HslColorPickerState extends State<HslColorPicker> {
  late int hue;
  late int saturation;
  late int lightness;

  HSLColor get color => HSLColor.fromAHSL(
        widget.value.alpha / 255,
        hue.toDouble(),
        saturation / 100,
        lightness / 100,
      );

  @override
  void initState() {
    super.initState();

    final hslColor = HSLColor.fromColor(widget.value);
    hue = hslColor.hue.toInt();
    saturation = (hslColor.saturation * 100).toInt();
    lightness = (hslColor.lightness * 100).toInt();
  }

  void onValueChanged(
    int newHue,
    int newSaturation,
    int newLightness,
  ) {
    setState(() {
      hue = newHue;
      saturation = newSaturation;
      lightness = newLightness;
    });

    final newColor = HSLColor.fromAHSL(
      color.alpha,
      newHue.toDouble(),
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
            labelText: 'H',
            value: hue,
            maxLength: 3,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^(?:[0-9]\d?|[12]\d{2}|3[0-5]\d)$'),
                replacementString: '$hue',
              ),
            ],
            onChanged: (value) {
              onValueChanged(
                value,
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
          child: NumberTextField.percentage(
            labelText: 'S',
            value: saturation,
            onChanged: (value) {
              onValueChanged(hue, value, lightness);
            },
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: NumberTextField.percentage(
            labelText: 'L',
            value: lightness,
            onChanged: (value) {
              onValueChanged(hue, saturation, value);
            },
          ),
        ),
      ],
    );
  }
}
