import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_converter.dart';
import 'color_space.dart';
import 'color_text_field.dart';

class RgbaColorTextFields extends StatelessWidget {
  const RgbaColorTextFields({
    required this.colorValue,
    required this.onChanged,
    required this.converter,
    super.key,
  });

  final List<String> colorValue;
  final ValueChanged<String> onChanged;
  final ColorsConverter converter;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      children: [
        ColorTextField(
          key: const Key('colorFieldRgbaRed'),
          value: colorValue[1],
          maxLength: 3,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.allow(
              RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'),
              replacementString: '${colorValue[1]}',
            )
          ],
          labelText: 'R',
          onChanged: (value) => onChanged(
            converter.convertColorValueToHex<List<String>>(
              colorSpace: ColorSpace.rgba,
              colorValues: [
                '${colorValue[0]}',
                value,
                '${colorValue[2]}',
                '${colorValue[3]}',
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        ColorTextField(
          key: const Key('colorFieldRgbaGreen'),
          value: '${colorValue[2]}',
          maxLength: 3,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.allow(
              RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'),
              replacementString: '${colorValue[2]}',
            )
          ],
          labelText: 'G',
          onChanged: (value) => onChanged(
            converter.convertColorValueToHex<List<String>>(
              colorSpace: ColorSpace.rgba,
              colorValues: [
                '${colorValue[0]}',
                '${colorValue[1]}',
                value,
                '${colorValue[3]}',
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        ColorTextField(
          key: const Key('colorFieldRgbaBlue'),
          value: '${colorValue[3]}',
          maxLength: 3,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.allow(
              RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'),
              replacementString: '${colorValue[3]}',
            )
          ],
          labelText: 'B',
          onChanged: (value) => onChanged(
            converter.convertColorValueToHex<List<String>>(
              colorSpace: ColorSpace.rgba,
              colorValues: [
                '${colorValue[0]}',
                '${colorValue[1]}',
                '${colorValue[2]}',
                value,
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        ColorTextField(
          key: const Key('colorFieldRgbaAlpha'),
          value: '${colorValue[0]}',
          maxLength: 3,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.allow(
              RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'),
              replacementString: '${colorValue[0]}',
            )
          ],
          labelText: 'A',
          onChanged: (value) => onChanged(
            converter.convertColorValueToHex<List<String>>(
              colorSpace: ColorSpace.rgba,
              colorValues: [
                value,
                '${colorValue[1]}',
                '${colorValue[2]}',
                '${colorValue[3]}',
              ],
            ),
          ),
        ),
      ],
    );
  }
}