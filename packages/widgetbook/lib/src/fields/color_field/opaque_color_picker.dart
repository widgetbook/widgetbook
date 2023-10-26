import 'package:flutter/widgets.dart';

import 'color_space.dart';
import 'hex_color_picker.dart';
import 'hsl_color_picker.dart';
import 'opaque_color.dart';
import 'rgb_color_picker.dart';

abstract class OpaqueColorPicker extends Widget {
  OpaqueColorPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  factory OpaqueColorPicker.fromColorSpace(
    ColorSpace colorSpace, {
    required OpaqueColor value,
    required ValueChanged<OpaqueColor> onChanged,
  }) {
    switch (colorSpace) {
      case ColorSpace.rgb:
        return RgbColorPicker(
          value: value,
          onChanged: onChanged,
        );
      case ColorSpace.hsl:
        return HslColorPicker(
          value: value,
          onChanged: onChanged,
        );
      case ColorSpace.hex:
        return HexColorPicker(
          value: value,
          onChanged: onChanged,
        );
    }
  }

  final OpaqueColor value;
  final ValueChanged<OpaqueColor> onChanged;
}
