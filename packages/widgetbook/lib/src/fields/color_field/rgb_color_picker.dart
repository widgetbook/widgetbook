import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'number_text_field.dart';

class RgbColorPicker extends StatefulWidget {
  const RgbColorPicker({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final Color value;
  final ValueChanged<Color> onChanged;

  @override
  State<RgbColorPicker> createState() => _RgbColorPickerState();
}

class _RgbColorPickerState extends State<RgbColorPicker> {
  late int red;
  late int green;
  late int blue;

  Color get color => Color.fromARGB(
        widget.value.alpha,
        red,
        green,
        blue,
      );

  @override
  void initState() {
    super.initState();
    red = widget.value.red;
    green = widget.value.green;
    blue = widget.value.blue;
  }

  void onValuesChanged(int newRed, int newGreen, int newBlue) {
    setState(() {
      red = newRed;
      green = newGreen;
      blue = newBlue;
    });

    widget.onChanged.call(color);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: NumberTextField(
            value: '$red',
            maxLength: 3,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'),
                replacementString: '$red',
              ),
            ],
            labelText: 'R',
            onChanged: (value) {
              onValuesChanged(
                int.tryParse(value) ?? red,
                green,
                blue,
              );
            },
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: NumberTextField(
            value: '$green',
            maxLength: 3,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'),
                replacementString: '$green',
              ),
            ],
            labelText: 'G',
            onChanged: (value) {
              onValuesChanged(
                red,
                int.tryParse(value) ?? green,
                blue,
              );
            },
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: NumberTextField(
            value: '$blue',
            maxLength: 3,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'),
                replacementString: '$blue',
              ),
            ],
            labelText: 'B',
            onChanged: (value) {
              onValuesChanged(
                red,
                green,
                int.tryParse(value) ?? blue,
              );
            },
          ),
        ),
      ],
    );
  }
}
