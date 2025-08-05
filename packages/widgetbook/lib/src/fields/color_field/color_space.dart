/// Represents the different color space formats that can be used
/// for color representation and conversion.
///
/// This enum defines the supported color spaces for color fields,
/// allowing users to work with colors in their preferred format.
enum ColorSpace {
  /// Hexadecimal color representation (e.g., #FF0000 for red).
  /// Uses base-16 notation with optional alpha channel.
  hex,

  /// Red, Green, Blue color space representation.
  /// Values typically range from 0-255 for each component.
  rgb,

  /// Hue, Saturation, Lightness color space representation.
  /// Hue ranges from 0-360 degrees, while saturation and lightness
  /// range from 0-100 percent.
  hsl,
}
