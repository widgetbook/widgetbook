import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_text_field.dart';

class RgbaColorTextFields extends StatelessWidget {
  const RgbaColorTextFields({
    required this.colorValue,
    required this.onChanged,
    super.key,
  });

  final List<String> colorValue;
  final ValueChanged<Color> onChanged;

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
            Color.fromARGB(
              int.tryParse(colorValue[0]) ?? 255, 
              int.tryParse(value) ?? 255,
              int.tryParse(colorValue[2]) ?? 255,
              int.tryParse(colorValue[3]) ?? 255,
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
            Color.fromARGB(
              int.tryParse(colorValue[0]) ?? 255, 
              int.tryParse(colorValue[1]) ?? 255,
              int.tryParse(value) ?? 255,
              int.tryParse(colorValue[3]) ?? 255,
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
            Color.fromARGB(
              int.tryParse(colorValue[0]) ?? 255, 
              int.tryParse(colorValue[1]) ?? 255,
              int.tryParse(colorValue[2]) ?? 255,
              int.tryParse(value) ?? 255,
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
            Color.fromARGB(
              int.tryParse(value) ?? 255, 
              int.tryParse(colorValue[1]) ?? 255,
              int.tryParse(colorValue[2]) ?? 255,
              int.tryParse(colorValue[3]) ?? 255,
            ),
          ),
        ),
      ],
    );
  }
}