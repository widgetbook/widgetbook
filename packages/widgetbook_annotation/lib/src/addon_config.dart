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

// TODO: add more addons
