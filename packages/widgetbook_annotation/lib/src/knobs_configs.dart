import 'knob_config.dart';

/// {@template cloud_knobs_configs}
/// A map between the name of the configuration and the list of knobs
/// configuration. This allows to create a matrix of knobs configurations
/// to test on Widgetbook Cloud while taking snapshots.
///
/// The key should be unique and descriptive name for the configuration.
/// For example, if this configuration tests long text with disabled state,
/// then the name can be "Disabled Long Text".
///
/// The value should be a list of [KnobConfig]s.
/// For example:
///
/// ```dart
/// {
///   'Disabled Long Text': [
///     StringKnobConfig('text', 'This is a long text...'),
///     BooleanKnobConfig('enabled', false),
///   ],
/// }
/// ```
///
/// See [KnobConfig] for more information about other
/// available configurations.
/// {@endtemplate}
typedef KnobsConfigs = Map<String, Iterable<KnobConfig<dynamic>>>;

extension KnobsConfigsExtension on KnobsConfigs {
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
