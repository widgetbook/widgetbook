typedef QueryGroup = Map<String, String>;

extension QueryGroupExtension on QueryGroup {
  /// Returns a copy of this query group with the given [key] updated to
  /// the given [value]. If either [key] or [value] is null,
  QueryGroup copyWithField({
    required String name,
    required String value,
  }) {
    final copy = Map<String, String>.from(this);
    copy.update(name, (_) => value, ifAbsent: () => value);

    return copy;
  }
}

/// Encodes a query group into a JSON-like representation.
///
/// Example:
///
/// ```
/// final queryGroup = {
///   'foo': 'bar',
///   'baz': 'qux',
/// };
///
/// final encoded = encodeQueryGroup(queryGroup);
///
/// print(encoded); // {foo:bar,baz:qux}
/// ```
String encodeQueryGroup(QueryGroup group) {
  final pairs = group.entries.map((entry) {
    // Both key and value are encoded to ensure that reserved
    // characters (e.g. `:`, `{`, `}` and `,`) are not misinterpreted.
    // For example, using a comma in a string value or a colon
    // in a date value would break the decoding process.
    final encodedKey = Uri.encodeComponent(entry.key);
    final encodedValue = Uri.encodeComponent(entry.value);

    return '$encodedKey:$encodedValue';
  });

  return '{${pairs.join(',')}}';
}

/// Decodes a string query group encoded value back to a [QueryGroup].
QueryGroup decodeQueryGroup(String? group) {
  if (group == null || group == '{}') return {};

  final params = group.substring(1, group.length - 1).split(',');

  return QueryGroup.fromEntries(
    params.map(
      (param) {
        final parts = param.split(':');
        final decodedKey = tryDecodeComponent(parts[0]);
        final decodedValue = tryDecodeComponent(parts[1]);

        return MapEntry(decodedKey ?? parts[0], decodedValue ?? parts[1]);
      },
    ),
  );
}

/// Decodes [component] using [Uri.decodeComponent],
/// but returns null if the decoding fails due to non-ASCII characters.
String? tryDecodeComponent(String component) {
  try {
    return Uri.decodeComponent(component);
  } on ArgumentError {
    return null;
  }
}
