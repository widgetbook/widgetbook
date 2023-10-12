import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../fields.dart';
import 'color_converter.dart';
import 'color_text_field.dart';

class HexColorTextFields extends StatelessWidget{

  const HexColorTextFields({
    required this.colorValue,
    required this.onChanged,
    required this.converter,
    super.key,
  });

  final String colorValue;
  final ValueChanged<String> onChanged;
  final ColorsConverter converter;
  
  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        ColorTextField(
          key: const Key('colorFieldHex'),
          value: '$colorValue',
          maxLength: 8,
          prefixIcon: const Icon(Icons.numbers),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^[0-9a-fA-F]{0,8}$'),
              replacementString: '$colorValue',
            ),
          ],
          onChanged: (value) {
            onChanged(
              converter.convertColorValueToHex<String>(
                colorSpace: ColorSpace.hex,
                colorValues: value,
              ),
            );
          },
        ),
      ],
    );
  }

}