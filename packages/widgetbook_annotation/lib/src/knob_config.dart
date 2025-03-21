class KnobConfig<T> {
  /// Creates a new [KnobConfig] using a [key] and a [value].
  ///
  /// Given the following Widgetbook URL:
  /// ```url
  /// /?knobs={size:2,color:blue,disabled:true}
  /// ```
  ///
  /// Then this would be:
  /// ```dart
  /// const KnobConfig('size', 2);
  /// const KnobConfig('color', 'blue');
  /// const KnobConfig('enabled', false);
  /// ```
  const KnobConfig(this.key, this.value);

  /// They key of the entry must match the name of the knob in **kebab-case**.
  final String key;

  /// The value of the entry must be a query string that can be parsed by the
  /// knob. The easiest way to get the value is to use the URL query string
  /// of a Widgetbook web build.
  final T value;

  MapEntry<String, T> toMapEntry() {
    return MapEntry(key, value);
  }
}
