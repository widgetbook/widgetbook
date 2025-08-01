import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Same as [Color] but without alpha channel.
@internal
class OpaqueColor {
  OpaqueColor(this.value) : assert(value >= 0 && value <= 0xffffff);

  OpaqueColor.fromChannels({
    required int red,
    required int green,
    required int blue,
  }) : value = (red << 16) | (green << 8) | blue;

  OpaqueColor.fromColor(
    Color color,
  ) :
        // Color.value was deprecated in Flutter 3.27.0, the alternative
        // apis (.r, .g, .b, .a) are not available in Color for our minimum
        // Flutter version (3.19.0), as they were also introduced in 3.27.0.
        // ignore: deprecated_member_use
        value = color.value & 0xffffff;

  final int value;

  /// The red channel of this color in an 8 bit value.
  int get red => (0xff0000 & value) >> 16;

  /// The green channel of this color in an 8 bit value.
  int get green => (0x00ff00 & value) >> 8;

  /// The blue channel of this color in an 8 bit value.
  int get blue => (0x0000ff & value) >> 0;

  Color toColor() {
    return Color(value | 0xff000000);
  }
}
