import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HexColorPicker extends StatelessWidget {
  const HexColorPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final Color value;
  final ValueChanged<Color> onChanged;

  String get hexValue => '${value.red.toRadixString(16).padLeft(2, '0')}'
      '${value.green.toRadixString(16).padLeft(2, '0')}'
      '${value.blue.toRadixString(16).padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: hexValue,
      maxLength: 6,
      decoration: const InputDecoration(
        counterText: '',
        prefixText: '#',
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9a-fA-F]'),
          replacementString: hexValue,
        ),
      ],
      onChanged: (value) {
        if (value.length != 6) return;

        final newColor = Color(
          int.tryParse('0x${this.value.alpha.toRadixString(16)}$value') ??
              0xFFFFFFFF,
        );

        onChanged.call(newColor);
      },
    );
  }
}
