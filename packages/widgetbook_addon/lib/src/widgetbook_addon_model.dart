abstract class WidgetbookAddOnModel<T> {
  const WidgetbookAddOnModel();

  /// Converts this to a [Map] that's used in the deep-linking of the addon
  /// via the query parameters of the router.
  Map<String, String> toMap();

  /// Converts a [map] to an instance to [T].
  T fromMap(Map<String, String> map);

  /// Encodes this into a JSON-like format without double quotes.
  /// For example: `{foo:bar,baz:qux}`
  String get encoded {
    final pairs = toMap().entries.map((entry) => '${entry.key}:${entry.value}');

    return '{${pairs.join(',')}}';
  }

  /// Decodes an [encoded] value into an instance of [T].
  T fromEncoded(String value) {
    final pairs = value.substring(1, value.length - 1).split(',');

    final map = Map<String, String>.fromEntries(
      pairs.map(
        (pair) {
          final parts = pair.split(':');
          return MapEntry(parts[0], parts[1]);
        },
      ),
    );

    return fromMap(map);
  }
}
