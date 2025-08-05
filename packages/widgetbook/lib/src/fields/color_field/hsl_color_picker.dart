import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import 'number_text_field.dart';
import 'opaque_color.dart';
import 'opaque_color_picker.dart';

@internal
class HslColorPicker extends StatefulWidget implements OpaqueColorPicker {
  const HslColorPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final OpaqueColor value;
  final ValueChanged<OpaqueColor> onChanged;

  @override
  State<HslColorPicker> createState() => _HslColorPickerState();
}

class _HslColorPickerState extends State<HslColorPicker> {
  late int hue;
  late int saturation;
  late int lightness;

  @override
  void initState() {
    super.initState();

    final hslColor = HSLColor.fromColor(
      widget.value.toColor(),
    );

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

    final newColor =
        HSLColor.fromAHSL(
          1,
          newHue.toDouble(),
          newSaturation / 100,
          newLightness / 100,
        ).toColor();

    widget.onChanged.call(
      OpaqueColor.fromColor(newColor),
    );
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
