/// A configuration entry for a WidgetbookAddon.
class AddonConfig {
  /// Creates a new [AddonConfig] using a [key] and a [value].
  ///
  /// Given the following Widgetbook URL:
  /// ```url
  /// /?Locale={name:de}
  /// ```
  ///
  /// Then this would be:
  /// ```dart
  /// const AddonConfigEntry('Locale', 'name:de');
  /// ```
  ///
  /// You can use other pre-defined entries for first-class addons that are
  /// provided by Widgetbook.
  const AddonConfig(this.key, this.value);

  /// They key of the entry must match the name of the addon.
  final String key;

  /// The value of the entry must be a query string that can be parsed by the
  /// addon. The easiest way to get the value is to use the URL query string
  /// of a Widgetbook web build.
  final String value;

  MapEntry<String, String> toMapEntry() {
    return MapEntry(key, value);
  }
}

/// [AddonConfig] for the LocalizationAddon.
class LocalizationAddonConfig extends AddonConfig {
  const LocalizationAddonConfig(
    String languageTag,
  ) : super(
          'Locale',
          'name:$languageTag',
        );
}

/// [AddonConfig] for the ThemeAddon.
class ThemeAddonConfig extends AddonConfig {
  const ThemeAddonConfig(
    String themeName,
  ) : super(
          'Theme',
          'name:$themeName',
        );
}

/// [AddonConfig] for the AlignmentAddon.
class AlignmentAddonConfig extends AddonConfig {
  /// Can only be one of the predefined values:
  /// - 'Top Left'
  /// - 'Top Center'
  /// - 'Top Right'
  /// - 'Center Left'
  /// - 'Center'
  /// - 'Center Right'
  /// - 'Bottom Left'
  /// - 'Bottom Center'
  /// - 'Bottom Right'
  const AlignmentAddonConfig(
    String alignmentName,
  )   : assert(
          // Since we can only use constant values, that means we cannot use
          // an enum or the [Alignment] class from Flutter. We have to use
          // strings instead, and we have to make sure that the string is
          // one of the predefined values.
          alignmentName == 'Top Left' ||
              alignmentName == 'Top Center' ||
              alignmentName == 'Top Right' ||
              alignmentName == 'Center Left' ||
              alignmentName == 'Center' ||
              alignmentName == 'Center Right' ||
              alignmentName == 'Bottom Left' ||
              alignmentName == 'Bottom Center' ||
              alignmentName == 'Bottom Right',
        ),
        super(
          'Alignment',
          'alignment:${alignmentName}',
        );
}

/// [AddonConfig] for the TextScaleAddon.
class TextScaleAddonConfig extends AddonConfig {
  const TextScaleAddonConfig(
    double factor,
  ) : super(
          'Text scale',
          'factor:$factor',
        );
}

/// [AddonConfig] for the ZoomAddon.
class ZoomAddonConfig extends AddonConfig {
  const ZoomAddonConfig(
    double zoom,
  ) : super(
          'Zoom',
          'value:$zoom',
        );
}
