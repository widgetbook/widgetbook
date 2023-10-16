import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_text_field.dart';

class HslColorTextFields extends StatelessWidget {
  const HslColorTextFields({
    required this.colorValue,
    required this.onChanged,
    required this.paramValue,
    super.key,
  });

  final List<String> colorValue;
  final void Function(Color? color, List<String> newValues) onChanged;
  final String paramValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      children: [
        ColorTextField(
          key: const Key('colorFieldHslHue'),
          value: '${colorValue[0]}',
          maxLength: 3,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.allow(
              RegExp(r'^(?:[0-9]\d?|[12]\d{2}|3[0-5]\d)$'),
              replacementString: '${colorValue[0]}',
            )
          ],
          labelText: 'H',
          onChanged: (value) => checkHueAndSaturation([
            value,
            '${colorValue[1]}',
            '${colorValue[2]}',
          ]),
        ),
        const SizedBox(
          width: 8,
        ),
        ColorTextField(
          key: const Key('colorFieldHslSaturation'),
          value: '${colorValue[1]}',
          maxLength: 3,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.allow(
              RegExp(r'^(0|[1-9][0-9]?|100)$'),
              replacementString: '${colorValue[1]}',
            )
          ],
          labelText: 'S',
          suffixText: '%',
          onChanged: (value) => checkHueAndSaturation([
            '${colorValue[0]}',
            value,
            '${colorValue[2]}',
          ]),
        ),
        const SizedBox(
          width: 8,
        ),
        ColorTextField(
          key: const Key('colorFieldHslLightness'),
          value: '${colorValue[2]}',
          maxLength: 3,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.allow(
              RegExp(r'^(0|[1-9][0-9]?|100)$'),
              replacementString: '${colorValue[2]}',
            )
          ],
          labelText: 'L',
          suffixText: '%',
          onChanged: (value) => checkLightness([
            '${colorValue[0]}',
            '${colorValue[1]}',
            value,
          ]),
        ),
      ],
    );
  }

  void checkHueAndSaturation(List<String> updatedValues) {
    final initialHsl = HSLColor.fromColor(Color(int.parse(paramValue, radix: 16)));
    final updateValue = HSLColor.fromAHSL(
      1, 
      (double.tryParse(updatedValues[0]) ?? initialHsl.hue), 
      (double.tryParse(updatedValues[1]) ?? (initialHsl.saturation * 100)) / 100, 
      (double.tryParse(updatedValues[2]) ?? (initialHsl.lightness * 100)) / 100,
    ).toColor();
    if (initialHsl.toColor() != updateValue) {
      onChanged(updateValue, updatedValues);
    } else {
      onChanged(null, updatedValues);
    }
  }

  void checkLightness(List<String> updatedValues) {
    final initialHsl = HSLColor.fromColor(Color(int.parse(paramValue, radix: 16)));
    final updateValue = HSLColor.fromAHSL(
      1, 
      (double.tryParse(updatedValues[0]) ?? initialHsl.hue), 
      (double.tryParse(updatedValues[1]) ?? (initialHsl.saturation * 100)) / 100, 
      (double.tryParse(updatedValues[2]) ?? (initialHsl.lightness * 100)) / 100,
    ).toColor();
    if (initialHsl.toColor() != updateValue) {
      onChanged(updateValue, updatedValues);
    }
  }
}