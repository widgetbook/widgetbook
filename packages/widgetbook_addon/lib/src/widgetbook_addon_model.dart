abstract class WidgetbookAddOnModel<T> {
  const WidgetbookAddOnModel();

  /// Required to allow proper deep linking including AddOn property selection
  ///
  /// Defaults to an empty Map, which means no query parameters are set for the
  /// route
  Map<String, String> toQueryParameter() {
    return {};
  }

  /// Encodes this into a JSON-like format without double quotes.
  /// For example: `{foo:bar,baz:qux}`
  String get encoded {
    final pairs = toQueryParameter()
        .entries
        .map((entry) => '${entry.key}:${entry.value}');

    return '{${pairs.join(',')}}';
  }

  /// Allows for parsing of [queryParameters] by using information from the
  /// router and from the initially provided [WidgetbookAddOnModel].
  ///
  /// If no [queryParameters] are available, return `null`.
  /// If [queryParameters] are available return a property `Setting` object.
  ///
  /// If not overridden, returns `null`.
  T? fromQueryParameter(
    Map<String, String> queryParameters,
  ) {
    return null;
  }

  /// Decodes an [encoded] value into an instance of [T].
  T? fromEncoded(String value) {
    if (value.isEmpty) return null;

    final pairs = value.substring(1, value.length - 1).split(',');

    final map = Map<String, String>.fromEntries(
      pairs.map(
        (pair) {
          final parts = pair.split(':');
          return MapEntry(parts[0], parts[1]);
        },
      ),
    );

    return fromQueryParameter(map);
  }
}
