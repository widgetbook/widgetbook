import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import 'opaque_color.dart';
import 'opaque_color_picker.dart';

@internal
class HexColorPicker extends StatelessWidget implements OpaqueColorPicker {
  const HexColorPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final OpaqueColor value;
  final ValueChanged<OpaqueColor> onChanged;

  String get hexValue =>
      '${value.red.toRadixString(16).padLeft(2, '0')}'
      '${value.green.toRadixString(16).padLeft(2, '0')}'
      '${value.blue.toRadixString(16).padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: hexValue,
      maxLength: 6,
      decoration: const InputDecoration(
        hintText: 'Enter a hex color',
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
        final source = int.tryParse(
          value,
          radix: 16,
        );

        if (value.length != 6 || source == null) return;
        onChanged.call(OpaqueColor(source));
      },
    );
  }
}
