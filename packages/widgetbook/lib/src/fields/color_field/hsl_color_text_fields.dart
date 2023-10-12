import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_converter.dart';
import 'color_space.dart';
import 'color_text_field.dart';

class HslColorTextFields extends StatelessWidget {
  const HslColorTextFields({
    required this.colorValue,
    required this.onChanged,
    required this.paramValue,
    required this.converter,
    super.key,
  });

  final List<String> colorValue;
  final void Function(String? hexValue, List<String> newValues) onChanged;
  final String paramValue;
  final ColorsConverter converter;

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
    final initialValue = converter.convertColorValueToHex<List<String>>(
      colorSpace: ColorSpace.hsl,
      colorValues: converter.getValueByColorSpace(
        colorSpace: ColorSpace.hsl,
        value: paramValue,
      ) as List<String>,
    );
    final updateValue = converter.convertColorValueToHex<List<String>>(
      colorSpace: ColorSpace.hsl,
      colorValues: updatedValues,
    );
    if (initialValue != updateValue) {
      onChanged(updateValue, updatedValues);
    } else {
      onChanged(null, updatedValues);
    }
  }

  void checkLightness(List<String> updatedValues) {
    final initialValue = converter.convertColorValueToHex<List<String>>(
      colorSpace: ColorSpace.hsl,
      colorValues: converter.getValueByColorSpace(
        colorSpace: ColorSpace.hsl,
        value: paramValue,
      ) as List<String>,
    );
    final updateValue = converter.convertColorValueToHex<List<String>>(
      colorSpace: ColorSpace.hsl,
      colorValues: updatedValues,
    );
    if (initialValue != updateValue) {
      onChanged(updateValue, updatedValues);
    }
  }
}