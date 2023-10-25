import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HexColorPicker extends StatelessWidget {
  const HexColorPicker({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final Color value;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
        initialValue: '${hexColor}',
        maxLength: 6,
        decoration: const InputDecoration(
          counterText: '',
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[0-9a-fA-F]'),
            replacementString: '$hexColor',
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
      ),
    );
  }

  String get hexColor => '${value.red.toRadixString(16).padLeft(2, '0')}'
      '${value.green.toRadixString(16).padLeft(2, '0')}'
      '${value.blue.toRadixString(16).padLeft(2, '0')}';
}
