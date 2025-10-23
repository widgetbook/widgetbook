import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'color_space.dart';
import 'hex_color_picker.dart';
import 'hsl_color_picker.dart';
import 'opaque_color.dart';
import 'rgb_color_picker.dart';

@internal
abstract class OpaqueColorPicker extends Widget {
  OpaqueColorPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  factory OpaqueColorPicker.fromColorSpace(
    ColorSpace colorSpace, {
    Key? key,
    required OpaqueColor value,
    required ValueChanged<OpaqueColor> onChanged,
  }) {
    switch (colorSpace) {
      case ColorSpace.rgb:
        return RgbColorPicker(
          key: key,
          value: value,
          onChanged: onChanged,
        );
      case ColorSpace.hsl:
        return HslColorPicker(
          key: key,
          value: value,
          onChanged: onChanged,
        );
      case ColorSpace.hex:
        return HexColorPicker(
          key: key,
          value: value,
          onChanged: onChanged,
        );
    }
  }

  final OpaqueColor value;
  final ValueChanged<OpaqueColor> onChanged;
}
