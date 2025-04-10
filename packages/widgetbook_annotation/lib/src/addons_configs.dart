import 'addon_config.dart';

/// {@template cloud_addons_configs}
/// A map between the name of the configuration and the list of addon
/// configurations. This allows to create a matrix of addon configurations
/// to test on Widgetbook Cloud while taking snapshots.
///
/// The key should be unique and descriptive name for the configuration.
/// For example, if this configuration tests the dark mode and
/// the German locale, then the name can be "Dark DE".
///
/// The value should be a list of [AddonConfig]s.
/// For example:
///
/// ```dart
/// {
///   'Dark DE': [
///     ThemeAddonConfig('Dark'),
///     LocalizationAddonConfig('de'),
///     AddonConfig('AddonName', 'name:value,otherName:otherValue'),
///   ],
/// }
/// ```
///
/// See [AddonConfig] for more information about other
/// available configurations.
/// {@endtemplate}
typedef AddonsConfigs = Map<String, Iterable<AddonConfig<dynamic>>>;

extension AddonsConfigsExtension on AddonsConfigs {
  Map<String, dynamic> toJson() {
    return map(
      (key, value) => MapEntry(
        key,
        Map<String, dynamic>.fromEntries(
          value.map((e) => e.toMapEntry()),
        ),
      ),
    );
  }
}
