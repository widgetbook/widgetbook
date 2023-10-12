import 'dart:math';

import 'color_space.dart';

class ColorsConverter {
  String convertColorValueToHex<T>({
    required ColorSpace colorSpace,
    required T colorValues,
  }) {
    switch (colorSpace) {
      case ColorSpace.hex:
        return colorValues as String;
      case ColorSpace.rgba:
        return rgbaToHex(colorValues as List<String>);
      default:
        return hslToHex(colorValues as List<String>);
    }
  }

  String rgbaToHex(List<String> rgba) {
    int alpha = int.tryParse(rgba[0]) ?? 0;
    int red = int.tryParse(rgba[1]) ?? 0;
    int green = int.tryParse(rgba[2]) ?? 0;
    int blue = int.tryParse(rgba[3]) ?? 0;
    return '${alpha.toRadixString(16).padLeft(2, '0')}${red.toRadixString(16).padLeft(2, '0')}${green.toRadixString(16).padLeft(2, '0')}${blue.toRadixString(16).padLeft(2, '0')}';
  }

  String hslToHex(List<String> hsl) {
    double h = double.tryParse(hsl[0]) ?? 0;
    double s = double.tryParse(hsl[1]) ?? 0;
    double l = double.tryParse(hsl[2]) ?? 0;

    h /= 360;
    s /= 100;
    l /= 100;

    double r = 0;
    double g = 0;
    double b = 0;
    if (s == 0) {
      r = g = b = l;
    } else {
      double q = l < 0.5 ? l * (1 + s) : l + s - l * s;
      double p = 2 * l - q;
      r = hueToRgb(p, q, h + 1 / 3);
      g = hueToRgb(p, q, h);
      b = hueToRgb(p, q, h - 1 / 3);
    }

    return rgbaToHex([
      '255',
      '${convertToRgbValue(r)}',
      '${convertToRgbValue(g)}',
      '${convertToRgbValue(b)}'
    ]);
  }

  // To maximize precision when converting from hsl to rgb,
  // we need to get the minimum value between the calculated value and 255
  int convertToRgbValue(double value) {
    return min((value * 256).floor(), 255);
  }

  // https://stackoverflow.com/questions/2353211/hsl-to-rgb-color-conversion
  double hueToRgb(double p, double q, double t) {
    if (t < 0) t += 1;
    if (t > 1) t -= 1;
    if (t < 1 / 6) return p + (q - p) * 6 * t;
    if (t < 1 / 2) return q;
    if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
    return p;
  }

  dynamic getValueByColorSpace({
    required ColorSpace colorSpace,
    required String value,
  }) {
    switch (colorSpace) {
      case ColorSpace.hex:
        return value;
      case ColorSpace.rgba:
        return hexToRgba(value);
      default:
        return hexToHsl(value);
    }
  }

  List<String> hexToRgba(String hex) {
    // Add the alpha value if it's not there
    if (hex.length == 1) {
      hex = ''.padLeft(8, hex);
    }
    // Add the alpha value if it's not there
    if (hex.length == 6) {
      hex = 'ff' + hex;
    }
    // Get the int value of the hex string
    int intColor = int.tryParse('0x$hex') ?? 0;
    int alpha = (intColor >> 24) & 0xFF;
    int red = (intColor >> 16) & 0xFF;
    int green = (intColor >> 8) & 0xFF;
    int blue = intColor & 0xFF;

    return ['$alpha', '$red', '$green', '$blue'];
  }

  List<String> hexToHsl(String hex) {
    // Start from rgba values because it's easier to convert to hsl
    List<int> rgbaValues =
        hexToRgba(hex).map((e) => int.tryParse(e) ?? 0).toList();

    // get all the values and divide them by 255 to get a value between 0 and 1
    double r = rgbaValues[1] / 255;
    double g = rgbaValues[2] / 255;
    double b = rgbaValues[3] / 255;

    // get the max and min value of the rgb values
    double max =
        [r, g, b].reduce((value, element) => value > element ? value : element);
    double min =
        [r, g, b].reduce((value, element) => value < element ? value : element);

    double h = 0;
    double s = 0;
    double l = (max + min) / 2;
    if (max == min) {
      h = s = 0;
    } else {
      // get the difference between the max and min value
      double difference = max - min;
      // calculate the saturation
      s = l > 0.5 ? difference / (2 - max - min) : difference / (max + min);
      // calculate the hue
      if (max == r) {
        h = (g - b) / difference + (g < b ? 6 : 0);
      } else if (max == g) {
        h = (b - r) / difference + 2;
      } else if (max == b) {
        h = (r - g) / difference + 4;
      }
      h /= 6;
    }

    return [
      '${(h * 360).toInt()}',
      '${(s * 100).toInt()}',
      '${(l * 100).toInt()}'
    ];
  }
}
